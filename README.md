# Wordle, Illustrated

A collection of daily Wordle puzzles, solved by me and illustrated by Midjourney, using each of my guesses as a prompt.

This project uses [Hugo](https://gohugo.io/) and is based on the [Congo theme](https://github.com/jpanther/congo).

## Frontmatter Generator Script

There's a small ruby script that creates article headers for new daily Wordles: `./generator.rb`.

It prompts the user to set up the basic set of data, using the Wordle number & prompt given to MidJourney. It will override existing files, so it should be the first task when creating a new entry.

```bash
## Start Generator:
$ ./generator.rb
```

Example:

```shell
What is the wordle number?
>> 722
What is the prompt?
>> light, gnome, grasp, guard --v 5.1
Did the MidJourney image represent LIGHT? (y/n)
>> y
Did the MidJourney image represent GNOME? (y/n)
>> y
Did the MidJourney image represent GRASP? (y/n)
>> y
Did the MidJourney image represent GUARD? (y/n)
>> y
Are you going to write a blog post about this Wordle? (y/n)
>> n
File created at ./content/722/index.md!
```
