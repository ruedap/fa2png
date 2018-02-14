# fa2png

Exports [Font Awesome icons](http://fontawesome.io/icons/) as PNG images for [Alfred Workflow](https://github.com/ruedap/alfred2-font-awesome-workflow).


## Setup

```
$ brew unlink imagemagick
$ brew install imagemagick@6 && brew link imagemagick@6 --force
$ brew install ghostscript
$ bundle install
$ bundle exec rake -T
rake compare   # Compare PNG files with previous version
rake generate  # Generate PNG files from Font Awesome TTF file
rake remove    # Remove PNG files
```

## License

http://ruedap.mit-license.org/2014


## Author

<a href="https://github.com/ruedap"><img src="https://avatars.githubusercontent.com/u/289671?v=3&s=300" alt="ruedap" title="ruedap" width="100" height="100"></a>
