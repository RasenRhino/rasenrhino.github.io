---
layout: page
title: Posts
permalink: /posts/

---
<p>Total posts: {{ site.posts.size }}</p>

 <ul class="post-list">
  {%- if site.posts.size > 0 -%}
      {%- for post in site.posts -%}
      <li>
        {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}
        <span class="post-meta">{{ post.date | date: date_format }}</span>
        <h3>
          <a class="post-link" href="{{ post.url | relative_url }}">
            {{ post.title | escape }}
          </a>
        </h3>
        {%- if site.show_excerpts -%}
          {{ post.excerpt }}
        {%- endif -%}
      </li>
      {%- endfor -%}
    
  {%- endif -%}
</ul>


