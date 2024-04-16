class CloudStorageException implements Exception {
  const CloudStorageException();
}

// create
class CouldNotCreateNoteException extends CloudStorageException {}

//read
class CouldNotGetAllNoteException extends CloudStorageException {}

//update
class CouldNotUpdateNoteException extends CloudStorageException {}

//delete
class CouldNotDeleteNoteException extends CloudStorageException {}
