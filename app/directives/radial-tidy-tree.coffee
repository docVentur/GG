#https://bl.ocks.org/mbostock/4063550
angular.module('gg')
  .directive 'radialTidyTree', (d3, d3Tip) ->
    link_func = (scope, iElement, iAttrs) ->

      margin = {top: 20, right: 30, bottom: 30, left: 100}

      width = 900
      height = 400

      full_width = width + margin.left + margin.right
      full_height = height + margin.top + margin.bottom + 20

      svg = d3.select iElement[0]
          .append "svg"
          .attr("width", full_width)
          .attr("height", full_height)
         .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
      draw_chart = (chart) ->
        console.log "here I should have data"
        console.log chart

        g = svg.append('g').attr('transform', 'translate(' + width / 2 + 40 + ',' + height / 2 + 90 + ')')
        stratify = d3.stratify()
          .parentId (d) ->
            d.name.substring(0, d.name.lastIndexOf('.'))

        tree = d3.tree().size([
          2 * Math.PI
          500
        ]).separation (a, b) ->
          (if a.parent == b.parent then 1 else 2) / a.depth

        radialPoint = (x, y) ->
          [
            (y = +y) * Math.cos(x -= Math.PI / 2)
            y * Math.sin(x)
          ]

        root = stratify(chart)
        console.log "made a stratify"
        console.log root
        root = tree(root)
        console.log "made a tree"
        console.log root
        link = g.selectAll('.link')
                .data root.links()
                  .enter()
                  .append('path')
                    .attr('class', 'link')
                    .attr('d', d3.linkRadial().angle((d) ->
                      d.x
        ).radius((d) ->
          d.y
        ))
        node = g.selectAll('.node').data(root.descendants()).enter().append('g').attr('class', (d) ->
          'node' + (if d.children then ' node--internal' else ' node--leaf')
        ).attr('transform', (d) ->
          'translate(' + radialPoint(d.x, d.y) + ')'
        )
        node.append('circle').attr 'r', 2.5
        node.append('text').attr('dy', '0.31em').attr('x', (d) ->
          if d.x < Math.PI == !d.children then 6 else -6
        ).attr('text-anchor', (d) ->
          if d.x < Math.PI == !d.children then 'start' else 'end'
        ).attr('transform', (d) ->
          'rotate(' + (if d.x < Math.PI then d.x - (Math.PI / 2) else d.x + Math.PI / 2) * 180 / Math.PI + ')'
        ).text (d) ->
          d.id.substring d.id.lastIndexOf('.') + 1
        return

      scope.$watchCollection 'data', (data) ->
        if data?
          svg.selectAll("*").remove()
          draw_chart(data)

    return {
      restrict: 'EA',
      scope: {
        data: "=",
        onClick: "&"
      },
      link: link_func
    }
