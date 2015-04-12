KarlMarxovChain
===============

KarlMarxovChain is a Twitter bot that uses Ruby to both make Markov chains and seed Markov chains with user content. I set it up in 2012, and it originally used [chatterbot](https://github.com/muffinista/chatterbot), but then it stopped working. It now talks to Twitter directly via the API.

This is not production ready, though I'd like to abstract out some of it to a general twitter bot (or contribute to chatterbot). There are no tests, etc. I wrote this before I heard of TDD, and I haven't really done much to change that other than make it look more like idiomatic Ruby.

It looks for a file called "configs.yml" which should look like this:

```
---
:since_id: {some Twitter id}
:consumer_key: {Gibberish from Twitter}
:consumer_secret: {Gibberish from Twitter}
:access_token: {Gibberish from Twitter}
:access_token_secret: {Gibberish from Twitter}
```

Mine is obviously in my .gitignore. 

The text sources are the two .txt files. They're not particularly clean, but they get the job done. Once is a bunch of early works of Marx's, and the other is _Das Kapital_. The corresponding .mmd files are PersistentDictionaries generated by [marky_markov](https://github.com/zolrath/marky_markov), which can't be seeded, as far as I can see, with user content.

Seeding uses my own implementation of a Markov Chain generator. It's three terms deep, and it works... OK.

After the KarlMarxovChain class definition, you can see the commands I use to spin it up and down. Change as you see fit.

Finally, I summon this via a cron command that looks like this:

```
*/2 * * * * cd $BOT_HOME/karlmarxovchain ; /complex/rvm/path/to/ruby KarlMarxovChain.rb >> cron.log 2>&1 
```
