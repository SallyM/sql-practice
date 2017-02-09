/* Question taken from Glassdoor FB interview reviews
https://www.glassdoor.com/Interview/Data-challenge-was-very-similar-to-the-ads-analysis-challenge-on-the-book-the-collection-of-data-science-takehome-challenge-QTN_1515288.htm
*/

CREATE TABLE song_count (
  rec_id INT NOT NULL AUTO_INCREMENT,
  date_of_record DATE NOT NULL,
  user_id INT,
  song_id INT,
  count INT,
  PRIMARY KEY(rec_id)
);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-01', 100, 100, 4);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-01', 100, 10, 2);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-01', 101, 100, 2);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-01', 101, 101, 1);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-02', 100, 101, 1);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-02', 100, 100, 2);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-02', 101, 101, 3);
INSERT INTO song_count (date_of_record, user_id, song_id, count) VALUES ('2017-01-02', 101, 10, 1);


CREATE TABLE lifetime_count (
  rec_id INT NOT NULL AUTO_INCREMENT,
  user_id INT,
  song_id INT,
  count INT,
  PRIMARY KEY (rec_id)
);
