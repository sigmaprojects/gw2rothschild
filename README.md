gw2rothschild
=============
**Description**
Rothschild is a platform developed to analyze and compare unique data to predict or explain certain trends. 
In this test example the market data from Guild Wars 2 to track market trends and fluctuation within the game that can explain popularity and change in user base.

## Features
* You can setup alerts to let you know when an item has reached a certain selling price, buying price, supply, demand, or our custom Component Upgrade Difference (C-Diff). Alerts can currently be configured or Daily, Twice a Week, or Weekly. The alerting feature requires you to be logged in and setup an email address.
* You can have a personal watchlist of items so you don't need to search for them every time you want to check the status of an item. The watchlist feature requires you to be logged in.
* For items with an upgrade component, the C-Diff price is a function of (Item Sale Price)-(Upgrade Buy Price). It's extreamly useful to see what items you can buy then salvage the materials worth more than what you paid for.
* Search for nearly all items in the Guild Wars 2 game, with filters that let you choose Rarity, Level, Type, and our personal favorite: Multi-Sort options.
* You are able to view the market trends of any item we have for as far as a month in the past.

## Platform
* Railo 4.1.2
* ColdBox 3.8.1 framework, including WireBox.
* MySQL 5.6 for the storage layer (Triggers lightly used, see: /config/gw2rothchild.sql for schema information)
* Highcharts for market graphing (http://www.highcharts.com/)
* A custom-butchered CB-Relax module for log viewing purposes.

## Additional Libraries
I also built these to aggregate all available data.
* cf-GW2Spidy - ColdFusion implementation of the GW2 Spidy API https://github.com/sigmaprojects/cf-GW2Spidy
* cfGW2API - ColdFusion implementation of the ArenaNet GW2 Public API
* cfGW2TradeAPI - ColdFusion implementation of the GuildWarsTrade API

## History
This application was built on Adobe ColdFusion 10 but was migrated to Railo.
Was using cfconcurrent (https://github.com/marcesher/cfconcurrent) for task scheduling, but later switched to simple cfscheduled tasks.
