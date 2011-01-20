module Network.Riakclient.RpbLink (RpbLink(..)) where
import Prelude ((+))
import qualified Prelude as P'
import qualified Text.ProtocolBuffers.Header as P'
 
data RpbLink = RpbLink{bucket :: P'.Maybe P'.ByteString, key :: P'.Maybe P'.ByteString, tag :: P'.Maybe P'.ByteString}
             deriving (P'.Show, P'.Eq, P'.Ord, P'.Typeable)
 
instance P'.Mergeable RpbLink where
  mergeEmpty = RpbLink P'.mergeEmpty P'.mergeEmpty P'.mergeEmpty
  mergeAppend (RpbLink x'1 x'2 x'3) (RpbLink y'1 y'2 y'3)
   = RpbLink (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3)
 
instance P'.Default RpbLink where
  defaultValue = RpbLink P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire RpbLink where
  wireSize ft' self'@(RpbLink x'1 x'2 x'3)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeOpt 1 12 x'1 + P'.wireSizeOpt 1 12 x'2 + P'.wireSizeOpt 1 12 x'3)
  wirePut ft' self'@(RpbLink x'1 x'2 x'3)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutOpt 10 12 x'1
             P'.wirePutOpt 18 12 x'2
             P'.wirePutOpt 26 12 x'3
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> P'.fmap (\ new'Field -> old'Self{bucket = P'.Just new'Field}) (P'.wireGet 12)
             18 -> P'.fmap (\ new'Field -> old'Self{key = P'.Just new'Field}) (P'.wireGet 12)
             26 -> P'.fmap (\ new'Field -> old'Self{tag = P'.Just new'Field}) (P'.wireGet 12)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> RpbLink) RpbLink where
  getVal m' f' = f' m'
 
instance P'.GPB RpbLink
 
instance P'.ReflectDescriptor RpbLink where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList []) (P'.fromDistinctAscList [10, 18, 26])
  reflectDescriptorInfo _
   = P'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".Riakclient.RpbLink\", haskellPrefix = [MName \"Network\"], parentModule = [MName \"Riakclient\"], baseName = MName \"RpbLink\"}, descFilePath = [\"Network\",\"Riakclient\",\"RpbLink.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".Riakclient.RpbLink.bucket\", haskellPrefix' = [MName \"Network\"], parentModule' = [MName \"Riakclient\",MName \"RpbLink\"], baseName' = FName \"bucket\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".Riakclient.RpbLink.key\", haskellPrefix' = [MName \"Network\"], parentModule' = [MName \"Riakclient\",MName \"RpbLink\"], baseName' = FName \"key\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".Riakclient.RpbLink.tag\", haskellPrefix' = [MName \"Network\"], parentModule' = [MName \"Riakclient\",MName \"RpbLink\"], baseName' = FName \"tag\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 26}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False}"