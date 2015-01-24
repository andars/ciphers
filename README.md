Ciphers
========

Double transposition cipher 
---------- 

### Usage

#### Encoding  

```bash 
λ ./double_transpose encode [first_key] [second_key] '[plaintext]'
```

##### Example  

```bash
λ ./double_transpose encode swag master 'whats your favorite color'
WHAUS YOVRF ATORI LECOO RT
```

#### Decoding

```bash
λ ./double_transpose decode first_key second_key 'cipher_text'
```

##### Example

```bash 
λ ./double_transpose decode swag master 'WHAUS YOVRF ATORI LECOO RT'
WHATSYOURFAVORITECOLOR
```
