# PythonRawHDR
# GBRG, 10-b MIPI format, 4032 x 3024

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np

def ReadBayerRaw(src_fname, in_width, in_height):
    in_length = in_width * in_height
    raw_buffer = np.fromfile(src_fname, dtype=np.uint8, count=in_length*5)
    # in_raw_file_size = int(in_length * 10 / 8)
    bayer_raw = np.zeros(in_length)

    convert_len = int(in_length/4)
    for i in range(convert_len):
        v0 = int(raw_buffer[5*i])
        v1 = int(raw_buffer[5*i+1])
        v2 = int(raw_buffer[5*i+2])
        v3 = int(raw_buffer[5*i+3])
        v4 = int(raw_buffer[5*i+4])
        bayer_raw[4*i]= (v0 << 2) | (v4 & 0x03)
        bayer_raw[4*i+1]= (v1 << 2) | ((v4>>2) & 0x03)
        bayer_raw[4*i+2]= (v2 << 2) | ((v4>>4) & 0x03)
        bayer_raw[4*i+3]= (v3 << 2) | ((v4>>6) & 0x03)

    return np.reshape(bayer_raw, (in_height, in_width))

def Crop(bayer_raw, new_x, new_y, new_width, new_height):
    return bayer_raw[new_y:(new_y+new_height):1, new_x:(new_x+new_width):1]

def InterpolateGChannel(bayer_raw):
    (in_width,in_height) = bayer_raw.shape
    g_interleaved = bayer_raw

    g_interleaved[0:in_height:2, 1:in_width:2] = 0

    g_interleaved[2:in_height-2:2, 3:in_width-2:2] =  \
        (g_interleaved[1:in_height-3:2, 3:in_width-2:2] + 
        g_interleaved[3:in_height-1:2, 3:in_width-2:2] +
        g_interleaved[2:in_height-2:2, 2:in_width-3:2] +
        g_interleaved[2:in_height-2:2, 4:in_width-1:2]) / 4 

    g_interleaved[1:in_height:2, 0:in_width:2] = 0

    g_interleaved[3:in_height-2:2, 2:in_width-2:2] = \
        (g_interleaved[2:in_height-3:2, 2:in_width-2:2] +
        g_interleaved[4:in_height-1:2, 2:in_width-2:2] +
        g_interleaved[3:in_height-2:2, 1:in_width-3:2] +
        g_interleaved[3:in_height-2:2, 3:in_width-1:2]) / 4 

    return g_interleaved

def GetGChannel(src_fname, in_width, in_height, reference_frame_idx):
    
    g_channel = []

    for n in range(0, len(src_fname), 1):
        raw = ReadBayerRaw(src_fname[n], in_width, in_height) 
        bayer_raw = Crop(raw, 1800, 0, 20, 20)

        # plt.figure()
        # plt.imshow(bayer_raw, cmap='gray', interpolation='nearest')
        # plt.title('Original Bayer GRBG: ' + str(n))
        # plt.draw()
        # plt.show(block=False)

        g_channel.append( InterpolateGChannel(bayer_raw) )

        plt.figure()
        plt.imshow(g_channel[n], cmap='gray')
        plt.title('Interpolated G Channel : ' + str(n))
        plt.show(block=False)
    
    return g_channel

# Read all these information from config file
src_fname = "./201709220634380r_4032x3024_157.raw"
in_width = 4032
in_height = 100 

g_channel = GetGChannel(src_fname, in_width, in_height, ref_idx)

plt.figure()
plt.imshow(g_channel, cmap='gray')
plt.title('G Channel Result')
plt.show(block=False)
