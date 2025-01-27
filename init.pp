class apache {
  # Установка пакета Apache
  package { 'apache2':
    ensure => installed,
  }

  # Убедитесь, что служба Apache запущена
  service { 'apache2':
    ensure => running,
    enable => true,
    subscribe => File['/etc/apache2/apache2.conf'], # Перезапуск службы при изменении конфигурации
  }

  # Копирование конфигурационного файла
  file { '/etc/apache2/apache2.conf':
    source => 'puppet:///modules/apache/apache2.conf',
    notify => Service['apache2'], # Перезапуск службы при изменении конфигурации
  }

  # Копирование файла индекса
  file { '/var/www/html/index.html':
    source => 'puppet:///modules/apache/index.html',
    ensure => file,
  }
}
