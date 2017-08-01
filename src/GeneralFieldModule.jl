"""
    GeneralFieldModule

Module for general fields.
"""
module GeneralFieldModule

export GeneralField

using FinEtools
using FinEtools.FTypesModule
using FinEtools.FieldModule
using FinEtools.FieldModule.@add_Field_fields

"""
    GeneralField{T<:Number} <: Field

General field.
"""
mutable struct GeneralField{T<:Number} <: Field
  @add_Field_fields()
end


"""
    GeneralField(data::FMat{T}=[]) where {T<:Number}

Constructor of general field.
"""
function GeneralField(data::FMat{T}=[]) where {T<:Number}
  values = deepcopy(data)
  dofnums = 0*similar(values,FInt)
  is_fixed = similar(values,Bool)
  fill!(is_fixed, 0)
  fixed_values = zeros(T,size(values))
  nfreedofs = 0
  return GeneralField(values, dofnums, is_fixed, fixed_values, nfreedofs)
end

end
