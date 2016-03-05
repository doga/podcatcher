
ARMANGIL'S PODCATCHER
=====================

Armangil's podcatcher is a podcast client for the command line.
It can download any type of content enclosed in RSS or Atom files, such as 
MP3 or other audio content, video and images. A search function for 
subscribing to feeds is also included. It provides several download 
strategies, supports BitTorrent, offers cache management, and generates 
playlists for media player applications. 

As argument, it accepts feeds (RSS or Atom) or subscription lists 
(OPML or iTunes PCAST), in the form of filenames or URLs (HTTP or FTP).
Alternatively, it accepts one feed or subscription list from the standard 
input.

BitTorrent is supported both internally (through the RubyTorrent library) 
and externally (.torrent files are downloaded, but the user handles
them using a BitTorrent application). The latter is currently the most
reliable method, as RubyTorrent is still in alpha phase.

Concurrency is not handled: simultaneous executions of this program should
target different directories.

Visit https://github.com/doga/podcatcher for more information.


Installation
------------
$ # Optional security step (do this once)
$ gem cert --add <(curl -Ls https://raw.githubusercontent.com/doga/podcatcher/master/certs/doga.pem)
$
$ # Install
$ # (Optional security paramater: --trust-policy HighSecurity)
$ gem install podcatcher --trust-policy HighSecurity
$
$ # Check the used version
$ podcatcher --version
3.2.3
$
$ # Optionally enable podcatcher MAN pages on Unix-like systems
$ gem install gem-man # do this once
$ gem man podcatcher # shows podcatcher MAN page


Usage
-----
podcatcher [options] [arguments] 

Options:
    -d, --dir DIR                    Directory for storing application state.
                                     Default value is current directory.
    -D, --cachedir DIR               Directory for storing downloaded content.
                                     Default value is the 'cache' subdirectory
                                     of the state directory (specified by 
                                     the --dir option).
                                     This option is ignored if this directory
                                     is inside the state directory, or if the
                                     state directory is inside this directory.
    -s, --size SIZE                  Size, in megabytes, of the cache directory
                                     (specified by the --cachedir option).
                                     0 means unbounded. Default value is 512.
                                     This option also sets the upper limit for
                                     the amount of content that can be downloaded
                                     in one session.
                                     Content downloaded during previous sessions
                                     may be deleted by podcatcher in order to
                                     make place for new content.
    -e, --[no-]empty                 Empty the cache directory before
                                     downloading content.
    -p, --[no-]perfeed               Create one subdirectory per feed
                                     in the cache directory.
    -S, --strategy S                 Strategy to use when downloading content:
                                     * back_catalog: download any content that
                                      has not been downloaded before; prefer
                                      recent content to older content (may 
                                      download more than one content file per
                                      feed),
                                     * one: download one content file (not 
                                      already downloaded) for each feed, with a 
                                      preference for recent content,
                                     * all: download all content, with a 
                                      preference for recent content; even 
                                      already downloaded content is downloaded 
                                      once again (may download more than one
                                      content file per feed),
                                     * chron: download in chronological order
                                      any content that has not been downloaded 
                                      before; this is useful for audiobook
                                      podcasts etc (may download more than one
                                      content file per feed),
                                     * chron_one: download the oldest content of
                                      each feed that has not already been 
                                      downloaded, 
                                     * chron_all: download all content in 
                                      chronological order, even if the content
                                      has already been downloaded (may download
                                      more than one content file per feed), 
                                     * new: download the most recent content 
                                      of each feed, if it has not already been 
                                      downloaded (DEPRECATED: use 'one' instead
                                      of 'new'),
                                     * cache: generate a playlist for content 
                                      already in cache.
                                     Default value is one.
    -C, --content REGEXP             A regular expression that matches the
                                     MIME types of content to be downloaded.
                                     Examples: '^video/', '^audio/mpeg$'.
                                     Default value is '', which matches any
                                     type of content.
    -l, --language LANG              A list of language tags separated by
                                     commas. Examples: 'en-us,de', 'fr'.
                                     A feed whose language does not match
                                     this list is ignored. By default, all
                                     feeds are accepted. See
                                     http://cyber.law.harvard.edu/rss/languages.html
                                     and
                                     http://cyber.law.harvard.edu/rss/rss.html#optionalChannelElements
                                     for allowed tags.
    -H, --horizon DATE               Do not download content older than
                                     the given date. The date has the format
                                     yyyy.mm.dd (example: 2007.03.22) or
                                     yyyy.mm (equivalent to yyyy.mm.01) or
                                     yyyy (equivalent to yyyy.01.01).
                                     By default, no horizon is specified.
    -r, --retries N                  Try downloading files (content, feeds
                                     or subscription lists) at most N times
                                     before giving up. Default value is 1.
    -t, --type TYPE                  Type of the playlist written to
                                     standard output. Accepted values are
                                     m3u, smil, pls, asx, tox, xspf.
                                     Default value is m3u.
    -m, --memsize N                  Remember last N downloaded content,
                                     and do not download them again. 
                                     0 means unbounded. Default value is 1000.
    -o, --order ORDER                The order in which feeds are traversed
                                     when downloading content:
                                     * random: randomizes the feed order,
                                      so that every feed has an equal chance
                                      when content is downloaded, even if
                                      the cache size is small and the number
                                      of feeds is big,
                                     * alphabetical: orders feeds
                                      alphabetically by using their titles,
                                     * sequential: preserves the argument 
                                      order (and the feed order in
                                      subscription lists),
                                     * reverse: reverses the feed order.
                                     Default value is random.
    -F, --function FUNCTION          Used function:
                                     * download: downloads content from
                                      specified feeds,
                                     * search: generates an OPML subscription
                                      list of feeds matching the specified
                                      query; the only options relevant for 
                                      search are -v, -r and -f.
                                     Default value is download.
    -f, --feeds N                    Do not download more than N feeds
                                     (when using the download function),
                                     or return the first N relevant feeds
                                     (when using the search function).
                                     0 means unbounded. Default value is 1000.
    -T, --torrentdir DIR             Copy torrent files to directory DIR.
                                     The handling of torrents through an
                                     external BitTorrent client is left to
                                     the user. If this option is not used,
                                     torrents are handled internally (if
                                     RubyTorrent is installed), or else
                                     ignored.
    -U, --uploadrate N               Maximum upload rate (kilobytes per second)
                                     for the internal BitTorrent client.
                                     Unbounded by default.
    -i, --itemsize N                 If downloaded content is less than N MB in
                                     size (where N is an integer), fetch other
                                     content of that same feed until this size
                                     is reached. 
                                     Default value is 0.
                                     The intent here is to ensure that podcatcher
                                     downloads about as much content from podcasts
                                     that frequently post small content (in
                                     terms of minutes) as it does from podcasts
                                     that post bigger content less frequently.
                                     This option was more relevant in the early
                                     days of podcasting when content size varied
                                     greatly from one podcast to another. You
                                     would rarely need to use this option today.
    -c, --[no-]cache                 Generate a playlist for content
                                     already in cache.
                                     DEPRECATED, use '--strategy cache'.
    -a, --[no-]asif                  Do not download content, only download
                                     feeds and subscription lists.
                                     Useful for testing.
    -v, --[no-]verbose               Run verbosely.
    -V, --version                    Display current version and exit.
    -h, --help                       Display this message and exit.
        --[no-]restrictednames       In the cache directory, make the names of
                                     created subdirectories and files acceptable
                                     for restrictive file systems such as VFAT
                                     and FAT, which are used on Windows and MP3
                                     player devices.
                                     Enabled by default.
    -A, --arguments FILENAME_OR_URL  Read arguments from specified file.
                                     Rules:
                                     * accepts one argument per line,
                                     * ignores empty lines and lines starting
                                       with #,
                                     * this option may be used several times
                                       in one command.
    -O, --options FILENAME_OR_URL    Read options from specified file.
                                     The options file uses the YAML format.

Usage examples:

    podcatcher http://feeds.feedburner.com/Ruby5

    podcatcher -O options.yaml -A feeds.txt

    podcatcher --dir ~/podcasts http://www.npr.org/podcasts.opml

    podcatcher --dir ~/podcasts --strategy cache > cache.m3u

    cat feeds.opml | podcatcher --dir ~/podcasts > latest.m3u

    podcatcher -vd ~/podcasts -s 500 -m 10_000 -t tox feeds.opml > latest.tox

    podcatcher -vF search news http://www.bbc.co.uk/podcasts.opml > bbc_news.opml

    podcatcher -F search -f 12 news http://www.npr.org/podcasts.opml > npr_news.opml


Support
-------
Please use https://github.com/doga/podcatcher for bug reports
and feature requests. 


License
-------
Armangil's podcatcher is released under the MIT Licence. 

