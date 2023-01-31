# Roman

A simple roman numeral converter to indo-arabic numbers. It uses a simple
grammar done mainly for practice.

## Usage
### Nix Flake

#### Building
```sh
git clone https://github.com/rafaelrc7/roman
cd roman
nix build
```

```sh
echo "III" | ./result/bin/roman
./result/bin/roman < file

```

### Linux
#### Build Dependencies
- Bison
- Flex
- Make
- GCC

#### Building
```sh
git clone https://github.com/rafaelrc7/roman
cd roman
make
```

#### Usage
```sh
echo "III" | ./roman
./roman < file
```


