import base64
import os


def str_encode(key, clear):
    enc = []
    for i in range(len(clear)):
        key_c = key[i % len(key)]
        enc_c = (ord(clear[i]) + ord(key_c)) % 256
        enc.append(enc_c)
    base_value = base64.urlsafe_b64encode(bytes(enc)).decode()
    base_value += "#+??+#"
    return base_value


def str_decode(key, enc):
    base_word = enc[:-6]
    dec = []
    base_word = base64.urlsafe_b64decode(base_word)
    for i in range(len(base_word)):
        key_c = key[i % len(key)]
        dec_c = chr((256 + base_word[i] - ord(key_c)) % 256)
        dec.append(dec_c)
    return "".join(dec)


def make_path(*args):
    list_args = args
    if list_args[-1] == "..":
        list_args += "",
    return os.path.join(*list_args)


if __name__ == "__main__":
    test = ""
    print(str_encode(test))
