# Reffime implementation plan

## Product direction
Reffime is presented as a premium fragrance and self-expression brand. The storefront prioritizes discovery and WhatsApp inquiry ordering, with payments kept modular for a later phase.

## Component structure
- `index.html`: semantic landing page shell, header, hero, collection, categories, benefits, process, social proof, promo, FAQ, newsletter and footer.
- `assets/`: local product and campaign imagery.
- `admin.html`: browser-based content studio with dashboard stats, product CRUD, image upload, visibility/featured/badge controls, homepage copy, promo, FAQ, preview and reset.
- `localStorage`: demo persistence for products, categories, site settings, cart and content. This is the adapter boundary for a future API/database/auth layer.

## Interaction model
- Product search, category filtering and sorting update the collection in place.
- Product details open in an accessible modal with quantity selection and add-to-cart.
- Cart produces an encoded WhatsApp inquiry summary; the phone number is configurable in admin.
- Admin changes are saved locally and reflected on the storefront; preview opens the public page.
- Reduced motion is respected through CSS and JS.

## Quality pass
- Responsive grid, mobile navigation, keyboard-friendly dialogs, validation, empty states, toasts, lazy-loaded media, semantic labels and SEO metadata.
- No live payment or authentication is faked. The dashboard is clearly demo-local and ready for a secure backend adapter.
