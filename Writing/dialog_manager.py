# --- IMPORTS ---
import os
import json

# --- JSON STRUCTURE ---
json_structure = {
    "title" : "MAJ",
    "themes" : [],
    "characters" : [],
    "room" : "",
    "vocabulary" : [],
    "complexity" : 0,
    "text" : ""
}

# --- FUNCTIONS ---
# Gather user input
def user_input():
    user_input = input("Please enter a command or 'help' to get a list of commands.\n>>")
    user_input = user_input.split(": ")
    command = user_input[0]
    properties = user_input[1:]
    # Match user input with available commands.
    match command:
        # List of available commands.
        case 'help':
            text = ("Here is a list of the available commands:"
                "\n- 'title: title_of_dialog'"
                "\n- 'themes: theme1, theme2, etc'"
                "\n- 'characters: character1, character2, etc'"
                "\n- 'room: room_of_dialog'"
                "\n- 'vocabulary: word1, word2, etc'"
                "\n- 'complexity: complexity_rating'")
            print(text)
        # Title match. Single value.
        case 'title':
            dialogs = fetch_dialogs_single(command, properties)
            for dialog in dialogs:
                print(f'{dialog}\n')
        # Themes match. List of values.
        case 'themes':
            dialogs = fetch_dialogs_list(command, properties)
            for dialog in dialogs:
                print(f'{dialog}\n')
        # Characters match. List of values.
        case 'characters':
            dialogs = fetch_dialogs_list(command, properties)
            for dialog in dialogs:
                print(f'{dialog}\n')
        # Room match. Single value.
        case 'room':
            dialogs = fetch_dialogs_single(command, properties)   
            for dialog in dialogs:
                print(f'{dialog}\n')
        # Vocabulary match. List of values.
        case 'vocabulary':
            dialogs = fetch_dialogs_list(command, properties)   
            for dialog in dialogs:
                print(f'{dialog}\n')
        # Complexity match. Single int value.
        case 'complexity':
            for i in range(len(properties)):
                properties[i] = int(properties[i])
            dialogs = fetch_dialogs_single(command, properties) 
            for dialog in dialogs:
                print(f'{dialog}\n')
        # in case of invalid command.
        case _:
            text = "Unknown command.\nUse the 'help' command for a list of available commands."
            print(text)     

# Fetching matching texts for a single value field.
def fetch_dialogs_single(field, properties):
    dialogs = set()
    # Accessing files.
    for filename in os.listdir(os.path.join(os.getcwd(), 'dialogs')):
        with open(os.path.join(os.getcwd(), f'dialogs/{filename}')) as f:
            d = json.load(f)
            # Matching values.
            for prop in properties:
                # print(f"{d[field]} == {prop}?")
                # Adding matching texts.
                if d[field] == prop:
                    dialog = f"{d['title']}: {d['text']}"
                    dialogs.add(dialog)
    return dialogs

# Fetching matching texts for a field containing list of values.
def fetch_dialogs_list(field, properties):
    dialogs = set()
    # Accessing files.
    for filename in os.listdir(os.path.join(os.getcwd(), 'dialogs')):
        with open(os.path.join(os.getcwd(), f'dialogs/{filename}')) as f:
            d = json.load(f)
            # Matching values.
            for prop in properties:
                for data in d[field]:
                    # print(f"{data} == {prop}?")
                    # Adding matching texts.
                    if data == prop:
                        dialog = f"{d['title']}: {d['text']}"
                        dialogs.add(dialog)
    return dialogs

# --- EXECUTION ---
user_input()