from PIL import Image
import os

for filename in os.listdir(os.path.join(os.getcwd(), 'sitelen_pona')):
    f = Image.open(os.path.join(os.getcwd(), f'sitelen_pona/{filename}'), 'r')
    f = f.crop((9, 10, 36, 38))
    p_map = f.load()
    width, height = f.size
    intensity = 0
    for i in range(width):
        for j in range(height):
            intensity += f.getpixel((i, j))[3]
    f.save(f'ascii_pona/{intensity}.png')

'''
f = Image.open(os.path.join(os.getcwd(), "sitelen_pona/test.png"))
f = f.crop((9, 10, 36, 38))
p_map = f.load()
width, height = f.size
intensity = 0
for i in range(width):
    for j in range(height):
        print(f.getpixel((i, j))[3])
f.save(f'{intensity}.png')
f.show()
'''