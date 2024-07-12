package test

import (
	"log"
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
	"gopkg.in/yaml.v3"
)

// Use existing resource group
const resourceGroup = "geretain-test-secrets-manager"
const defaultExampleTerraformDir = "examples/complete-rotation-policy"

const yamlLocation = "../common-dev-assets/common-go-assets/common-permanent-resources.yaml"

type Config struct {
	SmGuid   string `yaml:"secretsManagerGuid"`
	SmRegion string `yaml:"secretsManagerRegion"`
}

var smGuid string
var smRegion string

func TestMain(m *testing.M) {
	// Read the YAML file contents
	data, err := os.ReadFile(yamlLocation)
	if err != nil {
		log.Fatal(err)
	}
	// Create a struct to hold the YAML data
	var config Config
	// Unmarshal the YAML data into the struct
	err = yaml.Unmarshal(data, &config)
	if err != nil {
		log.Fatal(err)
	}
	// Parse the SM guid and region from data
	smGuid = config.SmGuid
	smRegion = config.SmRegion
	os.Exit(m.Run())
}

func setupOptions(t *testing.T, prefix string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:            t,
		TerraformDir:       defaultExampleTerraformDir,
		Prefix:             prefix,
		ResourceGroup:      resourceGroup,
		BestRegionYAMLPath: "../common-dev-assets/common-go-assets/cloudinfo-region-secmgr-prefs.yaml",
		TerraformVars: map[string]interface{}{
			"existing_sm_instance_guid":   smGuid,
			"existing_sm_instance_region": smRegion,
			"resource_tags":               []string{prefix},
		},
	})
	return options
}

func TestRunDefaultExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "iam-svcid-apikey-sm")
	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "iam-svcid-apikey-sm-upg")
	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
