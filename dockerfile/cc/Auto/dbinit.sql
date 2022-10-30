update sys_config set value='https://dc.serviceops.cloudaz.net:443' where config_key='server.name';
update sys_config set value='failover:(tcp://dc.serviceops.cloudaz.net:61616)' where config_key='config.activeMQConnectionFactory.brokerURL';
update sys_config set value='https://dc.serviceops.cloudaz.net:8443' where config_key='web.service.server.name';
update sys_config set value='tcp://dc.serviceops.cloudaz.net:61616' where config_key='activemq.broker.connector.bindAddress';
update sys_config set value='es' where config_key='search.engine.host';
truncate table component cascade;

