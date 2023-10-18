import { Web3Storage } from "web3.storage";

function getAccessToken() {
  // If you're just testing, you can paste in a token
  // and uncomment the following line:
  // return 'paste-your-token-here'

  // In a real app, it's better to read an access token from an
  // environement variable or other configuration that's kept outside of
  // your code base. For this to work, you need to set the
  // WEB3STORAGE_TOKEN environment variable before you run your code.
  return process.env.WEB3STORAGE_TOKEN;
}

export function makeStorageClient() {
  const token = getAccessToken();

  if (!token) {
    throw new Error("No token found");
  }

  return new Web3Storage({ token });
}

export function getFiles() {
  const fileInput = document.querySelector(
    'input[type="file"]',
  ) as HTMLInputElement | null;
  return fileInput?.files;
}

export async function storeFiles(files: File[]) {
  const client = makeStorageClient();
  const cid = await client.put(files);
  console.log("stored files with cid:", cid);
  return cid;
}

async function storeWithProgress(files: File[]) {
  // show the root cid as soon as it's ready
  const onRootCidReady = (cid: string) => {
    console.log("uploading files with cid:", cid);
  };

  // when each chunk is stored, update the percentage complete and display
  const totalSize = files.map((f) => f.size).reduce((a, b) => a + b, 0);
  let uploaded = 0;

  const onStoredChunk = (size: number) => {
    uploaded += size;
    const pct = 100 * (uploaded / totalSize);
    console.log(`Uploading... ${pct.toFixed(2)}% complete`);
  };

  // makeStorageClient returns an authorized web3.storage client instance
  const client = makeStorageClient();

  // client.put will invoke our callbacks during the upload
  // and return the root cid when the upload completes
  return client.put(files, { onRootCidReady, onStoredChunk });
}
