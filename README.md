# Daisie DB

Mit den hier enthaltenen Dateien lässt sich eine Postgres-Datenbank in einem Docker-Container erstellen und befüllen.
Voraussetzung ist, dass auf dem Host-System Docker installiert ist.

Zunächst muss **build.sh** ausgeführt werden, dabei werden ein Volume und das zugehörige Image der Datenbank erstellt.

Anschließend kann man **run.sh** ausführen um den Container der Datenbank zu starten.

**Anmerkung:** Die in der App verwendete Tabelle ist allerdings noch nicht in der Datenbank vorhanden, da sie über einen Talend-Job angelegt wird.
