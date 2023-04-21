#import "slides.typ": *

#let make-visible = block.with(spacing: 0cm, stroke: luma(200))

// ===================================
// ========= LAYOUT TOOLBOX ==========
// ===================================

#let optional-style(style, content) = {
  if style != none {
    style(content)
  } else {
    content
  }
}

#let base-slide(
  margin: 0cm,
  style: none,
  header: none,
  footer: none,
  body
) = {
  show: block.with(
    width: 100%, height: 100%,
    inset: margin,
    breakable: false,
  )

  show: optional-style.with(style)

  if header != none {
    show: place.with(dy: -margin)
    show: block.with(height: margin, width: 100%)
    header
  }

  block(width: 100%, height: 100%)[
    #body
    #v(1fr, weak: true)
  ]

  if footer != none {
    show: place.with(dy: 0cm)
    show: block.with(height: margin, width: 100%)
    footer
  }
}

#let title-body(margin: 0cm, style: none, spacing: 0cm, title, body) = base-slide(
  margin: margin,
  style: style,
)[
  #title
  #v(spacing)
  #body
  #v(1fr, weak: true)
]

#let two-body(margin: 0cm, style: none, spacing: 0cm, body-1, body-2) = base-slide(
  margin: margin,
  style: style,
)[
  #columns(gutter: spacing)[
    #body-1
    #colbreak()
    #body-2
  ]
]

// ===================================
// =========== KTH THEME =============
// ===================================

#let kth-logo-size = 2cm
#let kth-logo-spacing = (2/5)*kth-logo-size

#let kth-slide(body) = base-slide(
  margin: kth-logo-spacing,
  style: content => {
    set text(font: "Arial")
    content
  },
  footer: [
    #line(length: 100%)
    #set align(horizon)
    #show par: set block(above: 0cm)

    Made in Typst
    #h(1fr)
    #lorem(4)
    #h(1fr)
    #logical-slide.display()
  ],
  body
)

#let kth-fw-body(title, body) = kth-slide[
  #title-body(spacing: kth-logo-spacing)[
    // Title
    #stack(dir: ltr, spacing: kth-logo-spacing)[
      #image(
        width: kth-logo-size, height: kth-logo-size,
        "assets/KTH_Logotyp_RGB_2013.png",
      )
    ][
      #show: block.with(
        width: 100% - kth-logo-size - kth-logo-spacing,
        height: kth-logo-size,
      )
      #set text(size: 27pt, weight: "bold")
      #set align(horizon)
      #title
    ]
  ][
    // Main content
    #body
  ]
]

#let kth-fw-two-body(spacing: 1cm, title, body-1, body-2) = kth-fw-body(title)[
  #two-body(spacing: spacing, body-1, body-2)
]

#let kth-default(title, body) = kth-fw-body(title)[
  #grid(
    columns: (kth-logo-size, 1fr), column-gutter: kth-logo-spacing,
    [], body,
  )
]

#let kth-two-body(spacing: 1cm, title, body-1, body-2) = kth-default(title)[
  #two-body(spacing: spacing, body-1, body-2)
]

#let kth-title(title, subtitle) = kth-fw-body[][
  #show par: set block(spacing: 0.8em)

  #v(1cm)

  // Title
  #{
    set text(size: 28pt, weight: "bold")
    h(1cm)
    title
  }

  // Subtitle
  #{
    set text(size: 18pt)
    h(1cm)
    subtitle
  }

  #set align(bottom)
  #image(
    width: 100%, height: 50%,
    "assets/designelement_linjer_KTH-morkbla_rgb.png",
  )
  #v(.5cm)
]

// ===================================
// ========= DOCUMENT BEGIN ==========
// ===================================

#show: slides

#slide(layout: kth-title)[
  #lorem(4)
][Kaj Munhoz Arfvidsson]

#slide(layout: kth-default)[
  #lorem(6)
][
  #lorem(200)
]

#slide(layout: kth-two-body)[
  #lorem(6)
][ #lorem(100) ][ #lorem(100) ]

#slide(layout: kth-fw-body)[
  #lorem(6)
][
  #lorem(200)
]

#slide(layout: kth-fw-two-body)[
  #lorem(6)
][ #lorem(100) ][ #lorem(100) ]

#slide(layout: kth-default)[
  #lorem(6)
][
  #one-by-one[
    #lorem(50)
  ][

    #lorem(50)
  ][

    #lorem(50)
  ]
]

