$(document).ready(function() {

  new Morris.Bar({
    element: 'by_location_activity',
    data: $("#by_location_activity").data("computers"),
    xkey: 'location',
    ykeys: ['total_computers', 'active_computers', 'not_in_use_computers'],
    labels: ['Total', 'Currently In Use', "Free"]
  });

  new Morris.Donut({
    element: 'troubled_computers',
    data: $("#troubled_computers").data("computers")
  });


  new Morris.Bar({
    element: 'by_status_of_activity',
    data: $("#by_status_of_activity").data("computers"),
    xkey: 'status',
    ykeys: ['value'],
    labels: ['Computers']
  });


});
