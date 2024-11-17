import color from '@k-vyn/coloralgorithm'
import colors from './colors.json' assert { type: 'json' }
import fs from 'fs'
import yaml from 'yaml'

const offset = 10
const palette = {}
for (const { properties, options } of colors) {
  const result = color.generate(properties, options)
  const name = result[0].name
  for (const color of result[0].colors) {
    palette[`${name.toLowerCase()}-${color.step * offset}`] = color.hex
  }
}

const configFile = '../main.omp.yaml'
const config = fs.readFileSync(configFile, 'utf8')
// config.palette = palette
const output = yaml.stringify({ palette })

fs.writeFileSync(configFile, config.replace(/palette:(.|\s)*$/, output))
