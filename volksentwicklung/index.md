---
layout: default
title: Volksentwicklung
nolicense: true
readingtime: false
printpage: false
nosocial: true
---

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   <script type="text/javascript">
   google.charts.load('current', {'packages':['corechart'], 'language': 'de'});
    google.charts.setOnLoadCallback(drawChart);

  function drawChart() {

    var data = new google.visualization.DataTable();
    data.addColumn('date', '');
    data.addColumn('number', 'Volk 1');
    data.addColumn('number', 'Volk 2');
    data.addColumn('number', 'Volk 3');
    data.addColumn('number', 'Volk 5');

    data.addRows([
      [new Date('2016-09-25'),  37800, 80800, 41800, 41800],
      [new Date('2016-10-25'),  37800, 80800, 41800, 41800],
      [new Date('2016-11-02'),  4200,  6200,  3400, 3400]
    ]);

    var options = {
      chart: {
        title: 'Gewicht der Völker in Gramm',
        subtitle: 'Nettogewicht (ohne Beuten, Leerwabengewicht etc.)'
      },
      width: 900,
      height: 500,
      pointSize: 5,
      vAxis: {
          title: 'Gewicht (g)',
        }
    };

    var chart = new google.visualization.LineChart(document.getElementById('linechart_material'));

    chart.draw(data, options);
  }
   </script>

   <div id="linechart_material" style="width: 900px; height: 500px"></div>
 <br />

|Datum       | Volk 1 | Volk 2 | Volk 3 | Volk 5 | Bemerkung |
|------------|-------:|-------:|-------:|-------:|:----------|
| 20.06.2015 |  1.480 |  2.160 |        |        | beide Völker sitzen auf vier Rähmchen |
{: class="table table-striped table-condensed table-responsive"}
