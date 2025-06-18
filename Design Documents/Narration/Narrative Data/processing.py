# A SIMPLE SCRIPT TO PROCESS THE LIST OF SCENE FROM A COPY-PASTE OF MY LATEX FILE TO AN ACTUAL JSON FILE.

import re
import json

file_path = "raw_scenes.txt"
mysteries_regex = "(\\\\emph)"
scenes_regex = "\(Early\)$|\(Early-Mid\)$|\(Mid\)$|\(Mid-Late\)$|\(Late\)$"
mysteries = []
scenes = []
processed_dict = {}

with open(file_path, 'r') as f:
    scenes_sorter = -1
    for line in f:
        if re.search(mysteries_regex, line):
            text = re.sub("([\n\t]*)|(\\\\item)|(\\\\emph)|(\{)|(\})", "", line)
            text = re.sub("^ ", "", text)
            mysteries.append(text)
            scenes_sorter += 1
            scenes.append([])
        elif re.search(scenes_regex, line):
            stage = re.findall(scenes_regex, line)
            text = re.sub("([\n\t]*)|(\\\\item)", "", line)
            text = re.sub("^ ", "", text)
            text = re.sub(scenes_regex, "", text)
            scenes[scenes_sorter].append([text, stage])

for i,m in enumerate(mysteries):
    processed_dict[m] = scenes[i]

# Convert and write JSON object to file
with open("new_batch_of_scenes.json", "w") as outfile: 
    json.dump(processed_dict, outfile, indent=4)
