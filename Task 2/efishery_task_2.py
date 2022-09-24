import sys, json, re, statistics
import jellyfish
import pandas as pd

filepath = sys.argv[1]

with open(filepath, 'r') as file:
    raw_data  = file.read()
    json_data = json.loads(raw_data)
    file.close()

clean_data = []
for row in json_data:
    raw_names   = row["komoditas"]
    raw_weights = row["berat"]

    # remove trailing spaces and split based on multiple delimiters for both lists
    name_list   = re.split(' |, |,|dan|/|&', raw_names.strip())
    weight_list = re.split(' |, |,|dan|/|&', raw_weights.strip())

    # delete frequent invalid names
    name_list = [name for name in name_list if name not in ["ikan", "", "laut", "tawar", "nil", "pecel"]]

    # delete name with fewer than 3 letters and fewer than 4 total occurence in entire file (to root out typos and outliers)
    name_list = [name for name in name_list if len(name) >= 3 and raw_data.count(name) > 4]

    # remove non numerical data from weight list
    weight_list = [int(weight) for weight in weight_list if weight.isdigit()]

    # average the weight if it is an estimation
    if any(substring in raw_weights for substring in ["-", "sampai"]) and len(weight_list) > 1:
        weight_list = [statistics.mean(weight_list)]
    
    # fill missing weight values with average of other values obtained above
    if len(weight_list) > 0:
        while len(weight_list) < len(name_list):
            weight_list.append(weight_list[0])

    # cut off extra weight values
    if len(weight_list) > 0:
        weight_list = weight_list[:len(name_list)]

    # merge name list and weight list into key value pair
    merged_list = [(name_list[i], weight_list[i]) for i in range(0, len(name_list)) if len(name_list) > 0 and len(weight_list) > 0]

    # append cleaned data into final list
    if len(merged_list) > 0:
        clean_data.extend(merged_list)

# create DataFrame using cleaned data
df = pd.DataFrame(clean_data, columns = ['Fish', 'Weight'])

# aggregate all the rows using df transformation
df = df.groupby(['Fish'], as_index = False).sum().sort_values('Weight', ascending = True)

# merge fish that have lower weight with similarly named fish with higher weight
fish_list = df['Fish'].to_list()
for i in range(0, len(fish_list)):
    for j in range(i + 1, len(fish_list)):
        similarity = jellyfish.levenshtein_distance(fish_list[i], fish_list[j])
        if similarity < 3:
            df['Fish'] = df['Fish'].replace(fish_list[i], fish_list[j])

# aggregate all the rows using df transformation
df = df.groupby(['Fish'], as_index = False).sum().sort_values('Weight', ascending = False)
    
# print final ordered result
count = 1
for index, row in df.iterrows():
    print(f"{count}.\t{row['Fish']}: {row['Weight']}kg")
    count = count + 1