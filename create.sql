CREATE TABLE "activity_type" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL
);

CREATE TABLE "tag" (
  "tag" TEXT PRIMARY KEY
);

CREATE TABLE "track" (
  "id" SERIAL PRIMARY KEY,
  "geometry" GEOMETRY(LineStringZ, 4326) NOT NULL
);

CREATE TABLE "exercise_spot" (
  "id" SERIAL PRIMARY KEY,
  "geometry" TEXT NOT NULL,
  "track" INTEGER NOT NULL
);

CREATE INDEX "idx_exercise_spot__track" ON "exercise_spot" ("track");

ALTER TABLE "exercise_spot" ADD CONSTRAINT "fk_exercise_spot__track" FOREIGN KEY ("track") REFERENCES "track" ("id");

CREATE TABLE "tagged" (
  "track" INTEGER NOT NULL,
  "tag" TEXT NOT NULL,
  PRIMARY KEY ("track", "tag")
);

CREATE INDEX "idx_tagged__tag" ON "tagged" ("tag");

ALTER TABLE "tagged" ADD CONSTRAINT "fk_tagged__tag" FOREIGN KEY ("tag") REFERENCES "tag" ("tag");

ALTER TABLE "tagged" ADD CONSTRAINT "fk_tagged__track" FOREIGN KEY ("track") REFERENCES "track" ("id");

CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY
);

CREATE TABLE "exercise_rating" (
  "id" SERIAL PRIMARY KEY,
  "grade" INTEGER NOT NULL,
  "review" TEXT NOT NULL,
  "exercise_spot" INTEGER NOT NULL,
  "user" INTEGER NOT NULL
);

CREATE INDEX "idx_exercise_rating__exercise_spot" ON "exercise_rating" ("exercise_spot");

CREATE INDEX "idx_exercise_rating__user" ON "exercise_rating" ("user");

ALTER TABLE "exercise_rating" ADD CONSTRAINT "fk_exercise_rating__exercise_spot" FOREIGN KEY ("exercise_spot") REFERENCES "exercise_spot" ("id");

ALTER TABLE "exercise_rating" ADD CONSTRAINT "fk_exercise_rating__user" FOREIGN KEY ("user") REFERENCES "user" ("id");

CREATE TABLE "record" (
  "id" SERIAL PRIMARY KEY,
  "start_time" TIMESTAMP NOT NULL,
  "end_time" TIMESTAMP NOT NULL,
  "calories" DECIMAL(12, 2) NOT NULL,
  "track" INTEGER NOT NULL,
  "activitytype" INTEGER NOT NULL,
  "user" INTEGER NOT NULL
);

CREATE INDEX "idx_record__activitytype" ON "record" ("activitytype");
CREATE INDEX "idx_record__track" ON "record" ("track");
CREATE INDEX "idx_record__user" ON "record" ("user");

ALTER TABLE "record" ADD CONSTRAINT "fk_record__activitytype" FOREIGN KEY ("activitytype") REFERENCES "activity_type" ("id");
ALTER TABLE "record" ADD CONSTRAINT "fk_record__track" FOREIGN KEY ("track") REFERENCES "track" ("id");
ALTER TABLE "record" ADD CONSTRAINT "fk_record__user" FOREIGN KEY ("user") REFERENCES "user" ("id");

CREATE TABLE "rating" (
  "id" SERIAL PRIMARY KEY,
  "grade" INTEGER NOT NULL,
  "review" TEXT NOT NULL,
  "record" INTEGER NOT NULL
);

CREATE INDEX "idx_rating__record" ON "rating" ("record");

ALTER TABLE "rating" ADD CONSTRAINT "fk_rating__record" FOREIGN KEY ("record") REFERENCES "record" ("id")
