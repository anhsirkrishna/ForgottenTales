from PIL import Image, ImageDraw, ImageFont
import sys

input("Enter")
img_path = sys.argv[1]
img_pixel_count_x = int(sys.argv[2])
img_pixel_count_y = int(sys.argv[3])
print("Image path is : %s" % img_path)
input("Enter")
img = Image.open(img_path)
d1 = ImageDraw.Draw(img)
input("Enter")
counter = 1
xsize, ysize = img.size
print("Image size is : %s, %s" % (xsize, ysize))
input("Enter")
remainder = xsize % img_pixel_count_x
xsize = xsize - remainder

remainder = ysize % img_pixel_count_y
ysize = ysize - remainder
print("Image xsize : %s, ysize : %s" % (xsize, ysize))
input("Enter")
xi = 0
yi = 0
xblocks = int((xsize)/img_pixel_count_x)
yblocks = int(ysize/img_pixel_count_y)
for i in range(xblocks*yblocks):  
    counter_text = "%s" % counter
    d1.text((xi, yi), counter_text, fill=(255,0,0))
    xi = xi + img_pixel_count_x
    if (xi == (xsize)):
        yi = yi + img_pixel_count_y
        xi = 0
    counter = counter + 1

save_img_path = "%s_numbered.png" % img_path[:-4]
img.show()
img.save(save_img_path)
