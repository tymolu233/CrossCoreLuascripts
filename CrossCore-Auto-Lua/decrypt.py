import sys

def decrypt(path):
    with open(path, 'rb') as f:
        f.seek(152)
        data = bytearray(f.read())
    length = len(data)
    l = length // 100
    p = 0
    a = (length % 254) 
    while p < length:
        v = data[p]
        data[p] = v ^ a
        a = (data[p] + v) % 256
        p += l
    with open(path+'_decrypt', 'wb') as f:
        f.write(data[:-1])

if __name__ == '__main__':
    decrypt(sys.argv[1])