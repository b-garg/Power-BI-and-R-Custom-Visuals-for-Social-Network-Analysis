source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("DiagrammeR")
libraryRequireInstall("visNetwork")
libraryRequireInstall("data.table")

####################################################

################### Actual code ####################

# Calculate number of connections to plot. Max is taken because by default PowerBI will provide a vector instead of a single numeric value. #
limit_connection <- max(num_records)

# Read `dataset` as a data.table object with custom names. The dataset is also sorted by value in decreasing order to ensure the most frequent connections are at the top and the most important records are selected upto the limit specified by the user. #
dataset <- data.table('from' = dataset[[1]]
                      ,'to' = dataset[[2]]
                      ,'value' = dataset[[3]]
                      ,'col_sentiment' = dataset[[4]]
                      ,'col_type' = dataset[[5]]
                      ,'from_name' = dataset[[6]]
                      ,'to_name' = dataset[[7]]
                      ,'from_avatar' = dataset[[8]]
                      ,'to_avatar' = dataset[[9]])[
                        order(-value)][
                          1:min(nrow(dataset), limit_connection)]

# Unique User IDs are stored in a new table and a unique numeric userID (uid) is allocated #
user_ids <- data.table(id = unique(c(dataset$from, 
                                     dataset$to)))[, uid := 1:.N]

num_nodes <- nrow(user_ids) 

# Additional information is added to the user table including number of follower, size of node, number of records, type of the user, color codes, and avatar links #
user_ids <- merge(user_ids, dataset[, .(num_follower = uniqueN(to)), from], by.x = 'id', by.y = 'from', all.x = T)[is.na(num_follower), num_follower := 0][, size := num_follower][num_follower > 0, size := size + 50][, size := size + 10]

user_ids <- merge(user_ids, dataset[, .(sum_val = sum(value)), .(to, col_type)][order(-sum_val)][, id := 1:.N, to][id == 1, .(to, col_type)], by.x = 'id', by.y = 'to', all.x = T)

user_ids[id %in% dataset$from, col_type := '#42f548']

user_ids <- merge(user_ids, unique(rbind(dataset[, .('id' = from, 'Name' = from_name, 'avatar' = from_avatar)],
                                         dataset[, .('id' = to, 'Name' = to_name, 'avatar' = to_avatar)])),
                  by = 'id')

# Merger the unique user ID created back to dataset to get from and to user id's #
dataset <- merge(dataset, user_ids[, .(id, uid)],
                 by.x = "from", by.y = "id")

dataset <- merge(dataset, user_ids[, .(id, uid_retweet = uid)],
                 by.x = "to", by.y = "id")

user_ids <- user_ids[order(uid)]

# Create Node dataframe to create the visualization #
nodes <- create_node_df(n = num_nodes, 
                        type = "lower",
                        style = "filled",
                        color = user_ids$col_type, 
                        shape = 'circularImage', #"dot", 
                        data = user_ids$uid,
                        value = user_ids$size,
                        image = user_ids$avatar,
                        title = paste0("<p>Name: <b>", user_ids$Name,"</b><br>",
                                       "Super UID <b>", user_ids$id, "</b><br>",
                                       "# followers <b>", user_ids$num_follower, "</b><br>",
                                       "</p>")
)

# Create Edge dataframe to create the visualization #
edges <- create_edge_df(from = dataset$uid,
                        to = dataset$uid_retweet,
                        arrows = "to",
                        color = dataset$col_sentiment)

# Create Visualization and store it in a variable `p` #
p = visNetwork(nodes, edges) %>%
  visOptions(highlightNearest = list(enabled =TRUE, degree = 1, hover = T)) %>%
  visPhysics(stabilization = list(enabled = FALSE, iterations = 10), adaptiveTimestep = TRUE,
             barnesHut = list(avoidOverlap = 0.2, damping = 0.15, gravitationalConstant = -5000)) 

####################################################

############# Create and save widget ###############
internalSaveWidget(p, 'out.html');
####################################################

################ Reduce paddings ###################
ReadFullFileReplaceString('out.html', 'out.html', ',"padding":[0-9]*,', ',"padding":0,')
####################################################
