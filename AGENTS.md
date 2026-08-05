# Werstener Biene

Jekyll 4.4.1 static site (German) for a hobby beekeeping operation. Custom layouts/includes (no theme) based on a BootstrapMade-style template. No CI/CD, no test framework, no linter, no formatter.

## Commands

| Action | Command |
|--------|---------|
| Dev server | `bundle exec jekyll serve` (port 4000) |
| Dev server + livereload | `bundle exec jekyll serve --livereload` |
| Build | `bundle exec jekyll build` |
| Install deps | `bundle install` |
| A11y scan | `cd scripts/axe-scan && npm install && npx axe-scan` — dev server must be running on port 4000 (URLs in `scripts/axe-scan/urls.txt`) |

`_config.yml` is not reloaded by `jekyll serve` — restart after editing it.

## Architecture

- **Layouts** `_layouts/`: `home.html` hardcodes `class="index-page"`; `default.html` / `blog_details.html` / `content_page.html` / `blog_overview.html` use `{{ body_class }}`, which is set per page in frontmatter (e.g. `blog-details`, `contact-page`). Posts use `layout: blog_details`; `seiten/blog.md` uses `layout: blog_overview`.
- **Includes** `_includes/`: `default/` (page chrome) and `homepage/` (home sections) Liquid partials.
- **Content**: Pages in root, `informationen/`, `seiten/`, dated posts in `_posts/`. Content is German.
- **Permalinks**: Pages in `informationen/` and `seiten/` set a `permalink:` in frontmatter (e.g. `/schwarm_gefunden/`, `/tags/`, `/suche/`). Nav (`_data/nav.yml`) and cross-references use these clean URLs, never source file paths.
- **Images**: `jekyll_picture_tag` generates responsive WebP. Presets in `_data/picture.yml` (`carousel`, `startseite`, `blogpost`, `startseite_recent_posts`), used via `{% picture preset path --alt ... %}`.
- **SEO head** `_includes/default/head.liquid` derives `<title>`, `meta description`, `canonical`, and Open Graph/Twitter tags from frontmatter: `title`, `description` (falls back to `page.excerpt`, then `site.description`), and `og:image` from `teaser_image` → `title_image` → `content_start_image`. Pages/posts should set `description` and a `title_image`/`teaser_image`.
- **CSS**: site-specific styles live in `assets/css/site.css` (loaded after `main.css`), not in `main.css` (the compiled template stylesheet). It holds the color variables (`--link-color`, `--link-hover-color`, etc.), link styling (underline + external-link icon via bootstrap-icons `\f1c5`), and image sizing overrides (`.about-3` at 70%, `.recent-posts .post-item` at 85%).
- **Post frontmatter**: `layout: blog_details`, `title`, `sub_line`, `title_image`, `teaser_image`, `content_title`, `description`, `category`. Draft posts are hidden from the build with `published: false`.
- **Search**: `assets/search/search.json` is a **Liquid template** (frontmatter + Liquid loop over posts), not a static JSON index — it is rendered into `_site/` at build time. Edit the template, not its content.
- **Blog pagination**: `jekyll-paginate-v2` (Gemfile + `plugins`, global `pagination:` block in `_config.yml` with `enabled: true` and `trail: before/after: 2`). Pagination is enabled per page via frontmatter; `seiten/blog.md` sets `pagination: {enabled, per_page: 6, permalink: 'page/:num/'}`. The frontmatter `permalink` is **appended to the page URL**, so it must be relative (`page/:num/`, not `/blog/page/:num/`). `_layouts/blog_overview.html` loops `paginator.posts` and renders a Liquid nav (`paginator.page_trail`, `previous_page`, `next_page`) that is hidden when `total_pages <= 1`.
- **Fonts**: self-hosted in `assets/fonts/` — no Google Fonts CDN request.
- **Forms**: PHP in `forms/` (`contact.php`, `SmtpMailer.php`). The contact form in `seiten/kontakt.html` posts to `/forms/contact.php` (validation JS in `assets/vendor/php-email-form/`). PHP does **not** run under `jekyll serve` — forms only work on the production server.
- **Config** `_config.yml` excludes `README.md`, `scripts/*`, `Gemfile*`, `AGENTS.md`, `_config_beta.yml` from the build. `_config_beta.yml` only overrides `url` to the beta domain (`werstenerbiene.de`); preview it with `--config _config.yml,_config_beta.yml`.
- `_site/` is a build artifact (gitignored) — never edit it.

## Known issues / gotchas

- **`forms/newsletter.php` is missing** from the repo (production-only) but referenced in `_includes/default/newsletter-cto.liquid:16`. It is only rendered when `site.contact.show-newsletter-form` is `true`, which is `false` in both configs — so the broken form is currently inactive. Don't flip it on without a working endpoint.
- **SMTP config** `forms/smtp_config.json` is gitignored. Copy `forms/smtp_config.json.example` and fill in credentials; `contact.php` falls back to PHP `mail()` when the file is missing.
- **`assets/scss/` contains only a `Readme.txt`** — styles are compiled CSS in `assets/css/`, not Sass.
- **Image paths in frontmatter must match existing files exactly** (`.jpg` vs `.jpeg`) — `jekyll_picture_tag` fails the build if the source image is missing.
