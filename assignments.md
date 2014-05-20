---
category: assignment
title: Assignments
layout: default
---

## Assignments

{% for assignment in site.assignments %}
* [{{assignment.title}}]({{assignment.url}})  
{% endfor %}
