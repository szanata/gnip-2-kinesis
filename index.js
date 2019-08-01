const Gnip = require( 'gnip' );
const { randomBytes } = require( 'crypto' );
const { Kinesis } = require( 'aws-sdk' );
const { kinesisStreamName, gnipUser, gnipPassword, gnipUrl } = require( './config' );

const kinesis = new Kinesis();

const stream = new Gnip.Stream( { url: gnipUrl, user: gnipUser, password: gnipPassword } );

stream.on( 'ready', () => {
  console.log( 'Stream ready!' );
} );

stream.on( 'tweet', async tweet => {
  console.log( 'Tweet received' );
  await kinesis.putRecord( {
    Data: JSON.stringify( tweet ),
    PartitionKey: randomBytes( 8 ).toString( 'hex' ),
    StreamName: kinesisStreamName
  } ).promise();
  
  console.log( 'Tweet sent to Kinesis' );
} );

stream.on( 'error', err => {
  console.error( err );
} );

stream.start();
