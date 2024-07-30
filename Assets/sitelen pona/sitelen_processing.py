# Imports
from PIL import Image 

# Character properties
char_dim = [45, 47]
margin = 1

# Path to image
# Source: https://www.kreativekorp.com/ucsur/charts/sitelen.html
# Link: https://www.kreativekorp.com/ucsur/charts/sitelen.png
path = "sitelen_characters.png"

# Collecting sitelen pona symbols, isolating them and making the background transparent.
def sitelen_process():
    # Getting image.
    original_sitelen = Image.open(path).convert('L')
    # Extracting original pixel map.
    or_p_map = original_sitelen.load()
    # Storing dimensions
    width, height = original_sitelen.size

    # Creating new image.
    new_sitelen = Image.new(mode="RGBA", size=(width, height))
    # New pixel map.
    new_p_map = new_sitelen.load()

    # Filling pixel map with transparency based on grayscale.
    for i in range(width):
        for j in range(height):
            trans = or_p_map[i, j]
            new_p_map[i, j] = (0, 0, 0, 255 - trans)

    for i in range(int((width - margin) / (char_dim[0] + margin))):
        for j in range(int((height - 1) / (char_dim[1] + 1))):
            box = (
                (i+1) * (char_dim[0] + margin) + 1,
                (j+1) * (char_dim[1] + margin) + 1,
                (i+2) * (char_dim[0] + margin),
                (j+2) * (char_dim[1] + margin)
                )
            char = new_sitelen.crop(box)
            char.save(f'character {i} {j}.png')

sitelen_process()