CREATE TABLE `bills` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `url` varchar(255) default NULL,
  `feed_uri` varchar(255) default NULL,
  `tweeter_id` int(11) default NULL,
  `house` varchar(255) default NULL,
  `bill_type` varchar(255) default NULL,
  `categories` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_bills_on_tweeter_id` (`tweeter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

CREATE TABLE `entry_items` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `type` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `publisher` varchar(255) default NULL,
  `published_date` varchar(255) default NULL,
  `published_time` datetime default NULL,
  `content` text,
  `entry_query_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `entry_source_id` int(11) default NULL,
  `twfy_uri` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_entry_items_on_entry_query_id` (`entry_query_id`),
  KEY `index_entry_items_on_entry_source_id` (`entry_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3418 DEFAULT CHARSET=utf8;

CREATE TABLE `entry_queries` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(255) default NULL,
  `bill_id` int(11) default NULL,
  `feed_uri` varchar(255) default NULL,
  `query` varchar(255) default NULL,
  `site_restriction` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_entry_queries_on_bill_id` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8;

CREATE TABLE `entry_sources` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(255) default NULL,
  `author_uri` varchar(255) default NULL,
  `author_name` varchar(255) default NULL,
  `item_host_uri` varchar(255) default NULL,
  `item_title_name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=utf8;

CREATE TABLE `outgoing_tweets` (
  `id` int(11) NOT NULL auto_increment,
  `dm_to` varchar(255) default NULL,
  `reply_to` varchar(255) default NULL,
  `message` varchar(255) default NULL,
  `tweeted` tinyint(1) default NULL,
  `tweeted_at` datetime default NULL,
  `tweeter_id` int(11) default NULL,
  `tweet_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_outgoing_tweets_on_tweeter_id` (`tweeter_id`),
  KEY `index_outgoing_tweets_on_tweet_id` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `slugs` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `sluggable_id` int(11) default NULL,
  `sequence` int(11) NOT NULL default '1',
  `sluggable_type` varchar(40) default NULL,
  `scope` varchar(40) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_slugs_on_name_and_sluggable_type_and_scope_and_sequence` (`name`,`sluggable_type`,`scope`,`sequence`),
  KEY `index_slugs_on_sluggable_id` (`sluggable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

CREATE TABLE `tweeters` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `full_name` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `bio` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

CREATE TABLE `tweets` (
  `id` int(11) NOT NULL auto_increment,
  `dm_to` varchar(255) default NULL,
  `reply_to` varchar(255) default NULL,
  `message` varchar(255) default NULL,
  `tweeted` tinyint(1) default NULL,
  `tweeted_at` datetime default NULL,
  `tweeter_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `entry_item_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_tweets_on_tweeter_id` (`tweeter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27789 DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090509164330');

INSERT INTO schema_migrations (version) VALUES ('20090509165329');

INSERT INTO schema_migrations (version) VALUES ('20090509165331');

INSERT INTO schema_migrations (version) VALUES ('20090509165332');

INSERT INTO schema_migrations (version) VALUES ('20090509165334');

INSERT INTO schema_migrations (version) VALUES ('20090509165336');

INSERT INTO schema_migrations (version) VALUES ('20090509213732');

INSERT INTO schema_migrations (version) VALUES ('20090510100458');

INSERT INTO schema_migrations (version) VALUES ('20090519174350');

INSERT INTO schema_migrations (version) VALUES ('20090525170339');