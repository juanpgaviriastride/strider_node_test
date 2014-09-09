App
===


## Project Resources

  * PT is used for managing stories:
    * https://www.pivotaltracker.com/s/projects/1145488
  * Git is used for source control, canonical repo is at https://bitbucket.org/nullind/contextsurgery_backend
  * Jenkins is used for Continuous Integration, CI server is located at http://162.209.94.221/
  * Staging server is at https://23.253.52.225  User: mimo Pass: mimo
  * ...

## Git practices

  * Use git pull --rebase instead of git --pull wherever possible to avoid meaningless merge commits in the project history.
  * ...

### Versioning

We are using: https://github.com/vojtajina/grunt-bump

Versioning is also used for `app.js?v=0.0.X` no cache parameter.

Let's say current version is `0.0.1`.

````
$ grunt bump
>> Version bumped to 0.0.2
>> Committed as "Release v0.0.2"
>> Tagged as "v0.0.2"
>> Pushed to origin

$ grunt bump:patch
>> Version bumped to 0.0.3
>> Committed as "Release v0.0.3"
>> Tagged as "v0.0.3"
>> Pushed to origin

$ grunt bump:minor
>> Version bumped to 0.1.0
>> Committed as "Release v0.1.0"
>> Tagged as "v0.1.0"
>> Pushed to origin

$ grunt bump:major
>> Version bumped to 1.0.0
>> Committed as "Release v1.0.0"
>> Tagged as "v1.0.0"
>> Pushed to origin

$ grunt bump:build
>> Version bumped to 1.0.0-1
>> Committed as "Release v1.0.0-1"
>> Tagged as "v1.0.0-1"
>> Pushed to origin

$ grunt bump:git
>> Version bumped to 1.0.0-1-ge96c
>> Committed as "Release v1.0.0-1-ge96c"
>> Tagged as "v1.0.0-1-ge96c"
>> Pushed to origin
````

If you want to jump to an exact version, you can use the ```setversion``` tag in the command line.

```
$ grunt bump --setversion=2.0.1
>> Version bumped to 2.0.1
>> Committed as "Release v2.0.1"
>> Tagged as "v2.0.1"
>> Pushed to origin
```

Sometimes you want to run another task between bumping the version and commiting, for instance generate changelog. You can use `bump-only` and `bump-commit` to achieve that:

```bash
$ grunt bump-only:minor
$ grunt changelog
$ grunt bump-commit
```

## Configuration

This shows all the available config options with their default values.

```js
bump: {
  options: {
    files: ['package.json'],
    updateConfigs: [],
    commit: true,
    commitMessage: 'Release v%VERSION%',
    commitFiles: ['package.json'], // '-a' for all files
    createTag: true,
    tagName: 'v%VERSION%',
    tagMessage: 'Version %VERSION%',
    push: true,
    pushTo: 'upstream',
    gitDescribeOptions: '--tags --always --abbrev=1 --dirty=-d' // options to use with '$ git describe'
  }
}
```


## Setting up development environment

  * ...

## Deploying

  * ...

## Testing

### Running tests

### Developing tests


### Troubleshoting
