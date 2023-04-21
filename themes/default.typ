
// ===============================
// ======== DEFAULT THEME ========
// ===============================

#let slides-default-theme(color: teal) = data => {
    let title-slide = {
        align(center + horizon)[
            #block(
                stroke: ( y: 1mm + color ),
                inset: 1em,
                breakable: false,
                [
                    #text(1.3em)[*#data.title*] \
                    #{
                        if data.subtitle != none {
                            parbreak()
                            text(.9em)[#data.subtitle]
                        }
                    }
                ]
            )
            #set text(size: .8em)
            #grid(
                columns: (1fr,) * calc.min(data.authors.len(), 3),
                column-gutter: 1em,
                row-gutter: 1em,
                ..data.authors
            )
            #v(1em)
            #data.date
        ]
    }

    let default(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("default variant of default theme only supports one body per slide")
        }
        let body = bodies.first()

        let decoration(position, body) = {
            let border = 1mm + color
            let strokes = (
                header: ( bottom: border ),
                footer: ( top: border )
            )
            block(
                stroke: strokes.at(position),
                width: 100%,
                inset: .3em,
                text(.5em, body)
            )
        }


        // header
        decoration("header", section.display())

        if "title" in slide-info {
            block(
                width: 100%, inset: (x: 2em), breakable: false,
                outset: 0em,
                heading(level: 1, slide-info.title)
            )
        }

        v(1fr)
        block(
            width: 100%, inset: (x: 2em), breakable: false, outset: 0em,
            body
        )
        v(2fr)

        // footer
        decoration("footer")[
            #data.short-authors #h(10fr)
            #data.short-title #h(1fr)
            #data.date #h(10fr)
            #logical-slide.display()
        ]
    }

    let wake-up(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake up variant of default theme only supports one body per slide")
        }
        let body = bodies.first()

        block(
            width: 100%, height: 100%, inset: 2em, breakable: false, outset: 0em,
            fill: color,
            text(size: 1.5em, fill: white, {v(1fr); body; v(1fr)})
        )
    }

    (
        title-slide: title-slide,
        variants: ( "default": default, "wake up": wake-up, ),
    )
}

