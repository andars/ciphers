Ciphers
========

Double transposition cipher 
---------- 

### Usage

#### Encoding  

```bash 
λ ./double_transposition.rb encode [first_key] [second_key] '[plaintext]'
```

##### Example  

```bash
λ ./double_transposition.rb encode swag master 'whats your favorite color'
OVORO WHAUR FTSYA TECIL OR 
```

#### Decoding

```bash
λ ./double_transposition.rb decode first_key second_key 'cipher_text'
```

##### Example

```bash 
λ ./double_transposition.rb decode swag master 'OVORO WHAUR FTSYA TECIL OR'
WHATSYOURFAVORITECOLOR
```
