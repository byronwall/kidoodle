/* KiddoDraw Service Worker */
const CACHE_VERSION = "kiddodraw-v1";
const APP_SHELL = ["./", "./index.html", "./manifest.webmanifest", "./sw.js"];

self.addEventListener("install", (e) => {
  self.skipWaiting();
  e.waitUntil(
    caches.open(CACHE_VERSION).then((cache) => cache.addAll(APP_SHELL))
  );
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    (async () => {
      const keys = await caches.keys();
      await Promise.all(
        keys.map((k) => k !== CACHE_VERSION && caches.delete(k))
      );
      await self.clients.claim();
    })()
  );
});

// Cache-first with background revalidate for same-origin
self.addEventListener("fetch", (e) => {
  const url = new URL(e.request.url);
  if (url.origin === location.origin) {
    e.respondWith(
      (async () => {
        const cached = await caches.match(e.request);
        if (cached) {
          e.waitUntil(
            (async () => {
              try {
                const fresh = await fetch(e.request);
                const cache = await caches.open(CACHE_VERSION);
                cache.put(e.request, fresh.clone());
              } catch {}
            })()
          );
          return cached;
        }
        try {
          const res = await fetch(e.request);
          const cache = await caches.open(CACHE_VERSION);
          cache.put(e.request, res.clone());
          return res;
        } catch {
          if (e.request.mode === "navigate")
            return caches.match("./index.html");
          throw new Error("Network error and not in cache");
        }
      })()
    );
  }
});
