svg = d3.select \body .append \svg
box = document.body.getBoundingClientRect!
m = 10
p = 20

svg.attr do
  width: box.width
  height: box.height
  viewBox: "0 0 #{box.width} #{box.height}"
  preserveAspectRatio: "xMidYMid"


cscale = d3.scale.ordinal! .domain <[這個字非常的長 這個字也是相當長 HastalavistaBaby 中文是不是也可以呢你猜猜看]> .range <[#f00 #0f0 #00f]>
legend = plotd3.rwd.legend! .scale cscale .padding [30,10] .size [box.width, 50]
legend-group = svg.append \g .attr class: "legend-group"
legend-group.call legend
lbox = legend.offset!
legend-group.attr transform: "translate(#{(box.width - lbox.0)/2} #{box.height - lbox.1 - m})"

xscale = d3.scale.linear! .range [m, box.width - m] .domain [100000 1000000]
x-axis-group = svg.append \g .attr class: "axis horizontal"
x-axis = plotd3.rwd.axis!orient \bottom .scale xscale
x-axis-group.call x-axis
x-axis-group.attr transform: "translate(0 #{box.height - x-axis.offset! - m - lbox.1 - p})"

yscale = d3.scale.linear! .range [box.height - x-axis.offset! - m - lbox.1 - p, m] .domain [100000 1000000]
y-axis-group = svg.append \g .attr class: "axis vertical"
y-axis = plotd3.rwd.axis!orient \left .scale yscale
y-axis-group.call y-axis
y-axis-group.attr transform: "translate(#{y-axis.offset! + m} 0)"

xscale.range [y-axis.offset! + m, box.width - m]
x-axis-group.call x-axis

resize = ->
  box = document.body.getBoundingClientRect!
  svg.attr do
    width: box.width
    height: box.height
    viewBox: "0 0 #{box.width} #{box.height}"
    preserveAspectRatio: "xMidYMid"
  legend.size [box.width, 50]
  legend-group.call legend
  lbox = legend.offset!
  legend-group.attr transform: "translate(#{(box.width - lbox.0)/2} #{box.height - lbox.1 - m})"

  xscale.range [y-axis.offset! + m, box.width - m]
  yscale.range [box.height - x-axis.offset! - m - p - lbox.1, m]
  x-axis-group.call x-axis
  y-axis-group.call y-axis
  x-axis-group.attr transform: "translate(0 #{box.height - x-axis.offset! - m - p - lbox.1})"
  y-axis-group.attr transform: "translate(#{y-axis.offset! + m} 0)"

window.addEventListener \resize, resize
