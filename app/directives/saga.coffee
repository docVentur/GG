angular.module('npc')
  .directive 'saga', (d3, d3Tip) ->
    link_func = (scope, iElement, iAttrs) ->
      margin = {top: 20, right: 30, bottom: 30, left: 100}

      width = 900
      height = 400

      full_width = width + margin.left + margin.right
      # we get numbers higher then should be max for tooltip generation, so give 20 padding
      full_height = height + margin.top + margin.bottom + 20

      svg = d3.select iElement[0]
          .append "svg"
          .attr("width", full_width)
          .attr("height", full_height)
         .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


      draw_chart = (chart) ->
        console.log "HELLO I WILL BE YOUR DOCTOR TODAY (DOCT-OR!)"
        x = d3.time.scale().range [0, width]
        x.domain [chart.report_start.valueOf(), chart.report_end.valueOf()]
        y = d3.scale.ordinal().rangeRoundBands [0, height]
        y.domain chart.systems.map (d) -> d.hostname
        console.log chart.systems
        hero = svg.selectAll(".hero")
          .data chart.records
          .enter()
          .append "rect"
            .attr "width", (d) -> return width - x(d.at.valueOf())
            .attr "height", 10
            .style "fill", (d) -> return chart.hero_color(d.hero)
            .attr "y", (d) -> return y(d.system) - 5
            .attr "x", (d) -> return x(d.at.valueOf())

        task = svg.selectAll(".task")
          .data chart.records
          .enter()
          .append "rect"
            .attr "width", (d) -> return width - x(d.at.valueOf())
            .attr "height", 10
            .style "fill", (d) -> return chart.task_color(d.task)
            .attr "y", (d) -> return y(d.system) + 5
            .attr "x", (d) -> return x(d.at.valueOf())

        system = svg.selectAll(".system")
          .data chart.systems
          .enter()
          .append "text"
          .text (d) -> return d.hostname
          .attr "y", (d) -> return y(d.hostname) + 10
          .attr "x", (d) -> return -60

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
