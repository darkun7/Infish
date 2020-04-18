extends Control

onready var chart_node = get_node('chart')

func _ready():
  chart_node.initialize(chart_node.LABELS_TO_SHOW.X_LABEL,
  {
    Investor = Color(0.58, 0.92, 0.07),
	Pengusaha = Color(1.0, 0.18, 0.18)
  })
  chart_node.set_labels(5)
  reset()
  set_process(true)

func reset():
  chart_node.create_new_point({
    label = 'JAN',
    values = {
    Investor = 5,
    Pengusaha = 5  
    }
  })

  chart_node.create_new_point({
    label = 'FEB',
    values = {
      Pengusaha = 5,
      Investor = 20
    }
  })

  chart_node.create_new_point({
    label = 'MAR',
    values = {
      Pengusaha = 6,
      Investor = 25
    }
  })

  chart_node.create_new_point({
    label = 'APR',
    values = {
      Pengusaha = 6,
      Investor = 30
    }
  })

  chart_node.create_new_point({
    label = 'MEI',
    values = {
      Pengusaha = 11,
      Investor = 35
    }
  })

  chart_node.create_new_point({
    label = 'JUN',
    values = {
      Pengusaha = 11,
      Investor = 55
    }
  })

  chart_node.create_new_point({
    label = 'JUL',
    values = {
      Pengusaha = 12,
      Investor = 75
    }
  })

  chart_node.create_new_point({
    label = 'AGT',
    values = {
      Pengusaha = 13,
      Investor = 69
    }
  })

  chart_node.create_new_point({
    label = 'SEP',
    values = {
      Pengusaha = 15,
      Investor = 79
    }
  })

  chart_node.create_new_point({
    label = 'OKT',
    values = {
      Pengusaha = 15,
      Investor = 87
    }
  })

  chart_node.create_new_point({
    label = 'NOV',
    values = {
      Pengusaha = 17,
      Investor = 86
    }
  })

  chart_node.create_new_point({
    label = 'DEC',
    values = {
      Pengusaha = 20,
      Investor = 94
    }
  })

