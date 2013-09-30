.. Last Modified: 09/27/2013

Lab 04: Wireshark Lab of DNS and HTTP
=======================================

Part 1: DNS Protocol
------------------------

Usage of *ipconfig*:
++++++++++++++++++++++

.. code-block:: bash

  ipconfig /all
  ipconfig /displaydns
  ipconfig /flushdns

Resource Records (RRs) in DNS distributed database:
+++++++++++++++++++++++++++++++++++++++++++++++++++++
  (Name, Value, Type, TTL)

Usage of *nslookup*
+++++++++++++++++++++
.. code-block:: bash

  nslookup [-option] name [server]
  
  nslookup www.eecs.mit.edu
  nslookup -type=A www.eecs.mit.edu
  nslookup -type=NS mit.edu
  nslookup -type=CNAME www.eecs.mit.edu name_of_server


Part 2: HTTP Protocol
------------------------
Web Caching
+++++++++++++

If-modified-since / Etag

Part 3: Miscellaneous
------------------------
Filters for Wireshark
++++++++++++++++++++++
Find the address of the webserver::

  http.host="gaia.cs.umass.edu"

Locate specific http connection::

  ip.addr==xxx.xxx.xxx.xxx && http




