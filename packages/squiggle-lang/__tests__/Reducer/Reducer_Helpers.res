// Reducer_Helpers
module ErrorValue = Reducer_ErrorValue
module ExternalExpressionValue = ReducerInterface.ExternalExpressionValue
module InternalExpressionValue = ReducerInterface.InternalExpressionValue
module Module = Reducer_Module

let removeDefaultsInternal = (iev: InternalExpressionValue.t) => {
  switch iev {
  | InternalExpressionValue.IEvModule(nameSpace) =>
    Module.removeOther(
      nameSpace,
      ReducerInterface.StdLib.internalStdLib,
    )->InternalExpressionValue.IEvModule
  | value => value
  }
}

let removeDefaultsExternal = (ev: ExternalExpressionValue.t): ExternalExpressionValue.t =>
  ev->InternalExpressionValue.toInternal->removeDefaultsInternal->InternalExpressionValue.toExternal

let rRemoveDefaultsInternal = r => Belt.Result.map(r, removeDefaultsInternal)
let rRemoveDefaultsExternal = r => Belt.Result.map(r, removeDefaultsExternal)
