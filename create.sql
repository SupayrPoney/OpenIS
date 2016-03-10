CREATE TABLE "activity_type" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL
);

CREATE TABLE "tag" (
  "tag" TEXT PRIMARY KEY
);

CREATE TABLE "track" (
  "id" SERIAL PRIMARY KEY,
  "geometry" GEOGRAPHY(LineStringZ, 4326) NOT NULL,
  "length" REAL NOT NULL
);

CREATE TABLE "exercise_spot" (
  "id" SERIAL PRIMARY KEY,
  "geometry" GEOGRAPHY(GeometryCollection, 4326) NOT NULL,
  "track_id" INTEGER NOT NULL
);

CREATE INDEX "idx_exercise_spot__track" ON "exercise_spot" ("track_id");
ALTER TABLE "exercise_spot" ADD CONSTRAINT "fk_exercise_spot__track" FOREIGN KEY ("track_id") REFERENCES "track" ("id");

CREATE TABLE "tagged" (
  "track_id" INTEGER NOT NULL,
  "tag" TEXT NOT NULL,
  PRIMARY KEY ("track_id", "tag")
);

CREATE INDEX "idx_tagged__tag" ON "tagged" ("tag");

ALTER TABLE "tagged" ADD CONSTRAINT "fk_tagged__tag" FOREIGN KEY ("tag") REFERENCES "tag" ("tag");
ALTER TABLE "tagged" ADD CONSTRAINT "fk_tagged__track" FOREIGN KEY ("track_id") REFERENCES "track" ("id");

CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY,
  "weight" REAL NOT NULL,
  "height" REAL NOT NULL,
  "male" BOOLEAN NOT NULL,
  "birth_year" INTEGER NOT NULL
);

CREATE TABLE "exercise_rating" (
  "id" SERIAL PRIMARY KEY,
  "grade" INTEGER NOT NULL,
  "review" TEXT,
  "exercise_spot_id" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL
);

CREATE INDEX "idx_exercise_rating__exercise_spot" ON "exercise_rating" ("exercise_spot_id");
CREATE INDEX "idx_exercise_rating__user" ON "exercise_rating" ("user_id");

ALTER TABLE "exercise_rating" ADD CONSTRAINT "fk_exercise_rating__exercise_spot" FOREIGN KEY ("exercise_spot_id") REFERENCES "exercise_spot" ("id");
ALTER TABLE "exercise_rating" ADD CONSTRAINT "fk_exercise_rating__user" FOREIGN KEY ("user_id") REFERENCES "user" ("id");

CREATE TABLE "record" (
  "id" SERIAL PRIMARY KEY,
  "start_time" TIMESTAMP NOT NULL,
  "end_time" TIMESTAMP NOT NULL,
  "calories" REAL NOT NULL,
  "track_id" INTEGER NOT NULL,
  "activity_type_id" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL
);

CREATE INDEX "idx_record__activitytype" ON "record" ("activity_type_id");
CREATE INDEX "idx_record__track" ON "record" ("track_id");
CREATE INDEX "idx_record__user" ON "record" ("user_id");

ALTER TABLE "record" ADD CONSTRAINT "fk_record__activity_type" FOREIGN KEY ("activity_type_id") REFERENCES "activity_type" ("id");
ALTER TABLE "record" ADD CONSTRAINT "fk_record__track" FOREIGN KEY ("track_id") REFERENCES "track" ("id");
ALTER TABLE "record" ADD CONSTRAINT "fk_record__user" FOREIGN KEY ("user_id") REFERENCES "user" ("id");

CREATE TABLE "rating" (
  "record_id" INTEGER PRIMARY KEY,
  "grade" INTEGER NOT NULL,
  "review" TEXT NOT NULL
);

ALTER TABLE "rating" ADD CONSTRAINT "fk_rating__record" FOREIGN KEY ("record_id") REFERENCES "record" ("id");
