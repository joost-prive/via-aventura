// Via Aventura — kleine interacties

// Jaar in footer
const yearEl = document.getElementById("year");
if (yearEl) yearEl.textContent = new Date().getFullYear();

// Scroll reveal
const revealTargets = document.querySelectorAll([
  ".works > .work",
  ".atelier-row",
].join(","));

revealTargets.forEach((el) => el.classList.add("reveal"));

const io = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("in");
        io.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.12 }
);
revealTargets.forEach((el) => io.observe(el));

// Project filter
const filterButtons = document.querySelectorAll(".filter-btn");
const projectItems = document.querySelectorAll("#projectGrid .work");

filterButtons.forEach((btn) => {
  btn.addEventListener("click", () => {
    const f = btn.dataset.filter;
    filterButtons.forEach((b) => b.classList.toggle("is-active", b === btn));
    projectItems.forEach((item) => {
      const show = f === "all" || item.dataset.cat === f;
      item.classList.toggle("is-hidden", !show);
    });
  });
});

// "Live →" links zonder URL: zachte hint
document.querySelectorAll("[data-soon]").forEach((a) => {
  a.addEventListener("click", (e) => {
    e.preventDefault();
    const original = a.textContent;
    a.textContent = "binnenkort live →";
    a.style.opacity = ".75";
    setTimeout(() => {
      a.textContent = original;
      a.style.opacity = "";
    }, 1600);
  });
});

// Smooth-scroll voor anchor links + focus voor a11y
document.querySelectorAll('a[href^="#"]').forEach((a) => {
  a.addEventListener("click", (e) => {
    const id = a.getAttribute("href");
    if (id.length > 1) {
      const target = document.querySelector(id);
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: "smooth", block: "start" });
        history.replaceState(null, "", id);
        // Verplaats focus naar het doel voor screenreader-gebruikers
        if (target.hasAttribute("tabindex") || /^(A|BUTTON|INPUT|SELECT|TEXTAREA|MAIN)$/.test(target.tagName)) {
          target.focus({ preventScroll: true });
        }
      }
    }
  });
});

// =========================================================================
// GitHub stats — fetch stars + last update for projects with a GH repo
// =========================================================================
(() => {
  const CACHE_KEY = "va-gh-cache-v1";
  const CACHE_MS = 6 * 60 * 60 * 1000; // 6h
  let cache = {};
  try { cache = JSON.parse(localStorage.getItem(CACHE_KEY) || "{}"); } catch {}

  const ghLinks = document.querySelectorAll('.work-link[href*="github.com/joost-prive/"]');
  const now = Date.now();

  const formatDate = (iso) => {
    const d = new Date(iso);
    const diff = (now - d.getTime()) / 86400000;
    if (diff < 1)   return "vandaag";
    if (diff < 2)   return "gisteren";
    if (diff < 30)  return `${Math.round(diff)} dagen geleden`;
    if (diff < 365) return `${Math.round(diff / 30)} maanden geleden`;
    return `${Math.round(diff / 365)} jaar geleden`;
  };

  const render = (link, data) => {
    let stats = link.nextElementSibling;
    if (!stats || !stats.classList.contains("work-stats")) {
      stats = document.createElement("span");
      stats.className = "work-stats";
      link.insertAdjacentElement("afterend", stats);
    }
    const parts = [];
    // Alleen sterren tonen als > 0 (0 sterren zegt niks)
    if (typeof data.stars === "number" && data.stars > 0) {
      parts.push(`<span class="gh-star">${data.stars}</span>`);
    }
    if (data.updated) parts.push(`<span class="gh-update">${formatDate(data.updated)}</span>`);
    stats.innerHTML = parts.join('<span class="gh-dot"> · </span>');
    requestAnimationFrame(() => stats.classList.add("loaded"));
  };

  ghLinks.forEach((link) => {
    const m = link.href.match(/github\.com\/joost-prive\/([^/?#]+)/i);
    if (!m) return;
    const repo = m[1];
    const cached = cache[repo];
    if (cached && (now - cached.ts) < CACHE_MS) {
      render(link, cached);
      return;
    }
    fetch(`https://api.github.com/repos/joost-prive/${repo}`)
      .then((r) => r.ok ? r.json() : null)
      .then((data) => {
        if (!data) return;
        const item = {
          stars: data.stargazers_count,
          updated: data.pushed_at || data.updated_at,
          ts: now,
        };
        cache[repo] = item;
        try { localStorage.setItem(CACHE_KEY, JSON.stringify(cache)); } catch {}
        render(link, item);
      })
      .catch(() => { /* gracefully skip on rate limit / network errors */ });
  });
})();

// Mobile nav toggle
const navToggle = document.querySelector(".nav-toggle");
const siteNav = document.querySelector(".site-nav");

if (navToggle && siteNav) {
  const closeNav = () => {
    document.body.classList.remove("nav-open");
    navToggle.setAttribute("aria-expanded", "false");
    navToggle.setAttribute("aria-label", "Menu openen");
  };
  const openNav = () => {
    document.body.classList.add("nav-open");
    navToggle.setAttribute("aria-expanded", "true");
    navToggle.setAttribute("aria-label", "Menu sluiten");
  };
  navToggle.addEventListener("click", () => {
    document.body.classList.contains("nav-open") ? closeNav() : openNav();
  });
  // Close menu when a nav link is clicked
  siteNav.querySelectorAll("a").forEach((a) => {
    a.addEventListener("click", closeNav);
  });
  // Close on Escape
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && document.body.classList.contains("nav-open")) {
      closeNav();
      navToggle.focus();
    }
  });
}
