window.draw_graph = ->
  ctx = document.getElementById("myChart");
  myChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: ["6日目", "５日目", "４日目", "３日目","2日目","1日前","今日"],
    datasets: [
        {
        label: '投稿した本の数',
        backgroundColor: 'rgba(102,255,129,0.2)',
        borderColor: 'rgba(0,0,255,1)',
        data: [@day6_books, @day5_books, @day4_books, @day3_books, @day2_books, @day1_books, @today_books]
        },
       ],
      },
    options: {
      title: {
        display: true,
        text: '７日間の投稿数の比較'
      },
      scales: {
        yAxes: [{
          ticks: {
            suggestedMin: 0,
            suggestedMax: 10,
            stepSize: 10,
          }
      }]
    }
});
