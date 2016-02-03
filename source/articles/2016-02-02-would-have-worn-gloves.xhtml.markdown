---
title: If I’d known there’d be so much typing, I would have worn gloves
date: 2016-02-02 13:30
tags: Middleman, Ruby, rbenv, GitHub Pages, OSX
summary: >
  Generating a website on <abbr title="Mac Operating System Ten" class="initialism">O.S.X.</abbr> 11 with <a href="https://middlemanapp.com">Middleman 4.0.0</a> and hosting it with GitHub. This is an idiots guide, the idiot being me. I had a frustrating time setting up this site and wanted to ease future installations with an aide-mémoire. Hopefully someone else might find this useful.

---

You should never *ever* enter into the Terminal commands you find in comments, on forums, or on personal websites like this one unless you understand what they are doing and not just what someone like me is claiming that they do. The terminal can do *bad* things to your computer. That said, these are the steps I took to install Middleman and they are a whole bunch of terminal commands.

Directories and folders are the same thing. However, to both follow convention and increase confusion, I am using <dfn>directory</dfn> when referring to the command line and Terminal application and <dfn>folder</dfn> when accessing the same thing using Finder.

Ruby uses software packages called <dfn>gems</dfn> which each contain an application or library.

## Installing the software to support Ruby

### Install <em>Xcode command line tools</em>
Why do you want to install the *Xcode command line tools*? Because you want *[Ruby](https://www.ruby-lang.org/en/)*.

Open the Terminal (by default it will open into your home folder which is fine) and enter:

``` bash
code-select –install
```

From [Middleman’s installation instructions](https://middlemanapp.com/basics/install/).

### Install <em>Homebrew</em>

Why do you want to install *Homebrew*? So that you can install *[rbenv](https://github.com/rbenv/rbenv)*.

To install Homebrew enter:

``` bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

From [Homebrew’s homepage](http://brew.sh).

To check if the installation is okay, you can enter:

``` bash
brew doctor
```

If it does show any issues, you’ll get no help from me.

### Install <em>rbenv</em>

Why do you want to install *rbenv*? So that you can have multiple versions of *Ruby* installed.

Even if you don’t want to work on different projects with different versions of Ruby using the same computer, Apple’s version of Ruby is updated at Apple’s leisure. At some point, something you install will require a newer version of Ruby.

rbenv basically redirects requests for ruby files to the version that matches the first `.ruby-version` file it finds by first searching the directory of the script you are executing and each of its ancestor directories until reaching the root of your filesystem. This means you can change the ruby version for your whole home directory, a collection of directories, and an individual directory.

In the Terminal enter:

``` bash
brew install rbenv ruby-build
```

[From rbenv’s GitHub page](https://github.com/rbenv/rbenv).

To complete the installation you also need to enter:

``` bash
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
```

Followed by:

``` bash
rbenv init
```

## Install an up-to-date version of <em>Ruby</em>

At the time I first published this, the most up to date version of Ruby was <em>2.3.0</em>.

### Installing Ruby

``` bash
rbenv install 2.3.0
```

### Using that Ruby version for your website

Create a new folder: `my_test_website`. Navigate Terminal to this directory as it is where the rest of the commands will be entered.

Using a text editor, create a new file with the contents:

``` text
2.3.0

```

Save the file as `my_test_website\.ruby-version`. This will determine that when working in `my_test_website`, you will be using Ruby version 2.3.0.

## Installing Middleman

### Gems

Install the *Middleman* gem by entering:

``` bash
gem install middleman
```

Then install the *Middleman blog* gem by entering:

``` bash
gem install middleman-blog
```

Create a new site by entering:

``` bash
middleman init --template=blog
```

This will populate `my_test_website` with all the Middleman files for your website.

## Add to GitHub

Add the folder to [GitHub Desktop](https://desktop.github.com) as a new repository. Make an initial commit of the existing files and then *rename the branch from “master” to “source”*. You need to make a commit before you can rename the branch and for a <q>[user or organization site](https://help.github.com/articles/user-organization-and-project-pages/)</q> the published site needs to be published into the “master” branch. Therefore, the code to generate it needs to be in another branch.

## Licence and read me files

Assuming that you have a `licence.txt` and a `README.markdown` file, to copy these unchanged from the `my_test_website` root directory into your build directory, add the following to `config.rb` after  `# Build-specific configuration` section:

``` ruby
# Copy files to build folder after build
after_build do
  print 'After_build fixes … '
  system("cp \licence.txt #{config[:build_dir] + '/licence.txt'}")
  system("cp \README.markdown #{config[:build_dir] + '/README.markdown'}")
  puts 'done.'
end
```

## Deploying on GitHub

Install the *Middleman deploy* gem. At time of writing [the <em>current release</em> of middleman-deploy is incompatible with Middleman <em>4.0.0</em>](https://github.com/middleman-contrib/middleman-deploy/issues/100) so you need to use [middleman-deploy version 2.0.0.pre.alpha](https://rubygems.org/gems/middleman-deploy/versions/1.0.0).

Add `gem 'middleman-deploy', '~> 2.0.0.pre.alpha'`
to `my_test_website\GEMFILE` and whilst you’re there, remove the windows specific gems by deleting the following:

``` ruby
# For faster file watcher updates on Windows:
gem 'idm', '~> 0.1.0', platforms: [:mswin, :mingw]

# Windows does not come with time zone data
gem 'tzinfo-data', platforms: [:mswin, :minnow, :jruby]
```

Then enter:

``` bash
bundle install
```

Open `my_test_website\config.rb` and, after the `# Copy files to build folder after build`, or if not present than the `# Build-specific configuration` section, add the following:

``` ruby
# Deploy to GitHub
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
  deploy.branch = 'master'
  deploy.commit_message = 'Published from build of source branch'
end
```

### Problems with Jekyll

GitHub has integrated support for another built in static website generator, [Jekyll](http://jekyllrb.com), this could cause problems with your site.

Create the following empty file:

``` text
my_test_website\source\.nojekyll
```

<q>This should only be necessary if your site uses directories that begin with an underscore, as Jekyll sees these as special directories and does not copy them to the final destination.</q> From [GitHub pages help files: <cite>Turning off Jekyll</cite>](https://help.github.com/articles/using-jekyll-with-pages/#turning-jekyll-off).


### Avoid git prompt for username and password

Publish your repository using GitHub Desktop. This will generate the rest of the configuration details for your repository.

If your GiHub password is short and easy to remember, change it. To avoid being prompted to type in your 30 characters long randomly generated password open the `.git/config` in your text editor.

Look for a line where the beginning matches `url = https://github.com/` and change that to `url = ssh://git@github.com/` (thanks to ‘[Shiva](http://www.hiregion.com/2013/03/avoid-git-prompt-for-username-and.html)’).

## In conclusion

You should now have a website published on GitHub. It is, of course, full of dummy text and only populated by an outdated example post. I wasn’t trying to cover setting up a website or a GitHub repository, just the awkward confluence of the two.