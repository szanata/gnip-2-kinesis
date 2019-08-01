# GNIP Kinesis

Connect to GNIP's PowerTrack and Send the data to Kinesis

## Setup

Build the docker image

`docker build .`

Set the config via env vars

```bash
AWS_REGION=< your region >
AWS_ACCESS_KEY_ID=< aws credential id >
AWS_SECRET_ACCESS_KEY=< aws credential secret>
AWS_ECR_REPOSITORY=< ecr repo name (only if you pla to send this to ECR, ignore otherwise )>
AWS_ECR_IMAGE_NAME=< ecr image name (only if you pla to send this to ECR, ignore otherwise )>
KINESIS_STREAM_NAME=< the stream where the data will be send >
GNIP_USERNAME=< gnip username >
GNIP_PASSWORD=< gnip password >
GNIP_URL=< gnip stream url >
```

Done!
