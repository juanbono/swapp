# [swapp](https://github.com/juanbono/swapp/)


In order to run this project you need to install [stack](https://docs.haskellstack.org/en/stable/README/) first and then:

``` 
# Build the project.
$ stack build

# Run the tests.
$ stack test

# Run the executable.
$ stack exec swapp

# Install the executable (Optional).
$ stack install
```

### Usage
If you have installed the swapp executable, you can run it as follows:
``` sh
$ swapp -f leia -s luke


```
Or if you want to run it with stack:
```
$ stack exec -- swapp -f leia -s luke
```
