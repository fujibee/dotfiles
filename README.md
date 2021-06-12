# Setup
- Type `git` on terminal then install git following instruction
- `git clone https://github.com/fujibee/dotfiles.git .dotfiles`
- `cd .dotfiles`
- `setup.sh`

# backup items
- Desktop/Documents/Download
- .ssh
- work

## How to crypt / decrypt files
See: https://superuser.com/questions/162624/how-to-password-protect-gzip-files-on-the-command-line

### Encrypt
```
tar cvfz xyz.tgz secret_dir
openssl enc -aes-256-cbc -e -in xyz.tgz -out xyz.tgz.enc
```
### Decrypt
```
openssl enc -aes-256-cbc -d -in xyz.tgz.enc -out xyz.tgz
tar xvfz xyz.tgz
```
