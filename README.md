## About

This is a template for an academic course website generated using
[Jekyll](http://jekyllrb.com/) and designed in
[Bootstrap](http://getbootstrap.com).  It will be compatible with hosting on
[Github Pages](https://pages.github.com/) when Github upgrades to
[Jekyll 2.0.0](https://github.com/jekyll/jekyll/releases/tag/v2.0.0) or
greater.

A sample course page formatted via this template can be viewed at
http://brentonk.github.io/github-course-starter/.


## Structure

The template is in the following directories and files.  Further explanation
of the directory structure is available in
[the Jekyll documentation](http://jekyllrb.com/docs/structure/).  These can,
in theory, be left unchanged.

* `_config.yml`: YAML configuration file for Jekyll
* `_includes/`: snippets that can be reused throughout the site
    * `credits_and_license.html`: footer text
* `_layouts/`: HTML layout templates
    * `default.html`: default layout
    * `assignment.md` and `note.md`: layouts for assignments and course
      notes, respectively
* `assets/`: CSS stylesheets, fonts, and Javascript code

Your actual course content goes in the following directories and files:

* `index.md`: course home page in Markdown format
* `syllabus.md`: syllabus in Markdown format
* `_assignments/`: a [collection](http://jekyllrb.com/docs/collections/)
  containing assignments in Markdown format
* `_data/`: data files in [YAML](http://www.yaml.org/) format
    * `course.yml`: information about the course and instructor
    * `license.yml`: (optional) information about the license for course
      content (e.g., Creative Commons)
* `_notes/`: a [collection](http://jekyllrb.com/docs/collections/) containing
  course notes in Markdown format


## Suggested Workflow

1. Fork this repository
2. Alter the template at will (e.g., replace the default Bootstrap CSS file
   with one of the more attractive options from
   [Bootswatch](http://bootswatch.com/))
3. Initialize a page for each of your courses by cloning your personal
   `github-course-starter`
    1. Leave the tracking branch created by `git clone` in place, so you can
       fetch and merge future changes to the template


## Issues

* Jekyll currently does not allow defaults to be set for collections (though
  this may change soon; see jekyll/jekyll#2405 and jekyll/jekyll#2419), so the
  front-matter for each note must contain

    ```yaml
    ---
    category: note
    layout: note
    ---
    ```

  and similarly for each assignment.

* Filenames for notes and assignments must correspond to the order you wish
  them to appear in the navbar, hence `notes/01-first-note.md`,
  `notes/02-second-note.md`, and so on.  It is probably possible to change
  this by including a custom ordering variable in the front matter of each
  note/assignment.
